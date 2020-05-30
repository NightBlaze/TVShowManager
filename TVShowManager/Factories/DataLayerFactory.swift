//
//  DataLayerFactory.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import Swinject

protocol IDataLayerFactory: IFactory {
    func localPersistentStoreInitializer() -> ILocalPersistentStoreInitializer
    func localPersistentStoreContext() -> ILocalPersistentStoreContext
}

final class DataLayerFactory: IFactory {
    private let container: Container
    private let mainFactory: IMainFactory

    init(container: Container, mainFactory: IMainFactory) {
        self.container = container
        self.mainFactory = mainFactory
    }

    func register() {
        container.register(ILocalPersistentStore.self) { _ in
            LocalPersistentStore()
        }.inObjectScope(.container)
    }
}

// MARK: - IDataLayerFactory

extension DataLayerFactory: IDataLayerFactory {
    func localPersistentStoreInitializer() -> ILocalPersistentStoreInitializer {
        return localPersistentStore() as ILocalPersistentStoreInitializer
    }

    func localPersistentStoreContext() -> ILocalPersistentStoreContext {
        return localPersistentStore() as ILocalPersistentStoreContext
    }
}

// MARK: - Private

private extension DataLayerFactory {
    func localPersistentStore() -> ILocalPersistentStore {
        return container.resolve(ILocalPersistentStore.self)!
    }
}
