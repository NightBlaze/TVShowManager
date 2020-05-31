//
//  TVShowProvider.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol ITVShowProvider: ITVShowProviderCreator {
}

protocol ITVShowProviderCreator {
    func createTVShow(title: String, year: Int, seasons: Int, completion: @escaping (Result<TVShowDAO, Error>) -> Void)
}

final class TVShowProvider: ITVShowProvider {
    private let lps: ILocalPersistentStoreContext

    init(lps: ILocalPersistentStoreContext) {
        self.lps = lps
    }
}

// MARK: - ITVShowProviderCreator

extension TVShowProvider: ITVShowProviderCreator {
    func createTVShow(title: String, year: Int, seasons: Int, completion: @escaping (Result<TVShowDAO, Error>) -> Void) {
        let tvShow = TVShowDAO.create(title: title, year: Int32(year), seasons: Int32(seasons), context: lps.backgroundContext)
        lps.save()
        // TODO: save to server
        completion(.success(tvShow))
    }
}
