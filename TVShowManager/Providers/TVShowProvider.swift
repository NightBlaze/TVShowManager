//
//  TVShowProvider.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import CoreData

typealias UpdatedItem = (TVShowDAO) -> Void

protocol ITVShowProvider: ITVShowProviderCreator, ITVShowProviderData {
}

protocol ITVShowProviderCreator {
    func createTVShow(title: String, year: Int, seasons: Int, completion: @escaping (Result<TVShowDAO, Error>) -> Void)
}

protocol ITVShowProviderData {
    func savedTVShows() -> [TVShowDAO]?
    func addListener(_ listener: ITVShowProviderDataUpdateListener)
    func removeListener(_ listener: ITVShowProviderDataUpdateListener)
}

protocol ITVShowProviderDataUpdateListener: class {
    func tvShowAdded(tvShow: TVShowDAO)
}

final class TVShowProvider: NSObject, ITVShowProvider {
    private let network: INetworkData
    private let lps: ILocalPersistentStoreContext
    private let fetchedResultsController: NSFetchedResultsController<TVShowDAO>
    private var listeners = NSHashTable<AnyObject>(options: .weakMemory)

    init(network: INetworkData,
         lps: ILocalPersistentStoreContext) {
        self.network = network
        self.lps = lps

        let request: NSFetchRequest<TVShowDAO> = TVShowDAO.fetchRequest()
        let sort = NSSortDescriptor(key: "createdDate", ascending: true)
        request.sortDescriptors = [sort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: lps.backgroundContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
    }
}

// MARK: - ITVShowProviderCreator

extension TVShowProvider: ITVShowProviderCreator {
    func createTVShow(title: String, year: Int, seasons: Int, completion: @escaping (Result<TVShowDAO, Error>) -> Void) {
        let tvShow = createTVShowInLPS(title: title, year: year, seasons: seasons)
        saveOnRemoteServer(tvShow: tvShow) { [weak self] result in
            // Ignore error result of saving TV show on remote server
            // because this behaviour is business-logic related,
            // e.g. we can remove the TV show locally, apply retry policy
            // or just show alert. Also handle error situation here
            // is out of scope this case study

            if case .success(let externalId) = result {
                tvShow.externalId = externalId
                self?.lps.save()
            }

            completion(.success(tvShow))
        }
    }
}

// MARK: - ITVShowProviderData

extension TVShowProvider: ITVShowProviderData {
    func savedTVShows() -> [TVShowDAO]? {
        try? fetchedResultsController.performFetch()
        return fetchedResultsController.fetchedObjects
    }

    func addListener(_ listener: ITVShowProviderDataUpdateListener) {
        listeners.add(listener)
    }

    func removeListener(_ listener: ITVShowProviderDataUpdateListener) {
        listeners.remove(listener)
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension TVShowProvider: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        guard let tvShow = anObject as? TVShowDAO else { return }
        switch type {
        case .insert:
            notifyListenersAboutAdding(tvShow: tvShow)
            break
        case .delete:
            break
        case .update:
            break
        case .move:
            break
        @unknown default:
            break
        }
    }

    private func notifyListenersAboutAdding(tvShow: TVShowDAO) {
        listeners.allObjects.forEach { listener in
            if let listener = listener as? ITVShowProviderDataUpdateListener {
                listener.tvShowAdded(tvShow: tvShow)
            }
        }
    }
}

// MARK: - Private

private extension TVShowProvider {
    func createTVShowInLPS(title: String, year: Int, seasons: Int) -> TVShowDAO {
        let tvShow = TVShowDAO.create(title: title, year: Int32(year), seasons: Int32(seasons), context: lps.backgroundContext)
        lps.save()
        return tvShow
    }

    func saveOnRemoteServer(tvShow: TVShowDAO, completion: @escaping (Result<String, Error>) -> Void) {
        let dto = SaveTVShowDTO(dao: tvShow)
        network.save(dto: dto, completion: completion)
    }
}
