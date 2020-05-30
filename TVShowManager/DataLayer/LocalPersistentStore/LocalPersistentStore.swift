//
//  LocalPersistentStore.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import CoreData

protocol ILocalPersistentStoreInitializer {
    func initializeLPS(_ completion: @escaping (Result<Bool, Error>) -> Void)
}

protocol ILocalPersistentStoreContext {
    var backgroundContext: NSManagedObjectContext! { get }
    func save()
}

protocol ILocalPersistentStore: ILocalPersistentStoreInitializer, ILocalPersistentStoreContext {
}

final class LocalPersistentStore: ILocalPersistentStore {
    enum Errors: Error {
        case storeURLisNil
    }

    private static let containerName = "TVShowManager"
    private static let sqliteName = containerName + ".sqlite"
    private var persistentContainer: NSPersistentContainer?
    private(set) var backgroundContext: NSManagedObjectContext!
}

// MARK: - ILocalPersistentStoreInitializer

extension LocalPersistentStore: ILocalPersistentStoreInitializer {
    func initializeLPS(_ completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            // 1. Create a container
            let container = NSPersistentContainer(name: LocalPersistentStore.containerName)

            // 2. Get an url to a sqlite file
            let url = try storeURL()

            // 3. Create a store description and with setted properties for the container
            let storeDescription = persistentStoreDescription(storeURL: url)

            // 4. Set the store description to the container
            container.persistentStoreDescriptions = [storeDescription]

            // 5. Load persistent store
            container.loadPersistentStores { _, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    // 6. Set the local variables
                    self.persistentContainer = container
                    self.backgroundContext = self.persistentContainer?.newBackgroundContext()
                    completion(.success(true))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
}

// MARK: - ILocalPersistentStoreContext

extension LocalPersistentStore: ILocalPersistentStoreContext {
    func save() {
        if backgroundContext?.hasChanges ?? false {
            do {
                try backgroundContext?.save()
            } catch let error {
                fatalError("Cannot save context \(error)")
            }
        }
    }
}

// MARK: - Private initialization

private extension LocalPersistentStore {
    func storeURL() throws -> URL {
        guard let documentsURL =  FileManager.documentsDirectory() else {
            throw Errors.storeURLisNil
        }

        return documentsURL.appendingPathComponent(LocalPersistentStore.sqliteName)
    }

    func persistentStoreDescription(storeURL: URL) -> NSPersistentStoreDescription {
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        storeDescription.timeout = 5.0
        storeDescription.type = NSSQLiteStoreType
        storeDescription.shouldAddStoreAsynchronously = false
        storeDescription.shouldInferMappingModelAutomatically = true
        storeDescription.shouldMigrateStoreAutomatically = true
        return storeDescription
    }
}
