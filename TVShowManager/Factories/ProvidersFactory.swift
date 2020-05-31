//
//  ProvidersFactory.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import Swinject

protocol IProvidersFactory: IFactory {
    func tvShowProviderCreator() -> ITVShowProviderCreator
    func tvShowProviderData() -> ITVShowProviderData
}

final class ProvidersFactory: IFactory {
    private let container: Container
    private let mainFactory: IMainFactory

    init(container: Container, mainFactory: IMainFactory) {
        self.container = container
        self.mainFactory = mainFactory
    }

    func register() {
        container.register(ITVShowProvider.self) { [unowned self] _ in
            let network = self.mainFactory.networkFactory().networkData()
            let lps = self.mainFactory.dataLayerFactory().localPersistentStoreContext()
            return TVShowProvider(network: network, lps: lps)
        }.inObjectScope(.container)
    }
}

// MARK: - IProvidersFactory

extension ProvidersFactory: IProvidersFactory {
    func tvShowProviderCreator() -> ITVShowProviderCreator {
        return tvShowProvider() as ITVShowProviderCreator
    }

    func tvShowProviderData() -> ITVShowProviderData {
        return tvShowProvider() as ITVShowProviderData
    }
}

// MARK: - Private

private extension ProvidersFactory {
    func tvShowProvider() -> ITVShowProvider {
        return container.resolve(ITVShowProvider.self)!
    }
}
