//
//  NetworkFactory.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import Swinject

protocol INetworkFactory: IFactory {
    func networkInitializer() -> INetworkInitializer
    func networkData() -> INetworkData
}

final class NetworkFactory: IFactory {
    private let container: Container
    private let mainFactory: IMainFactory

    init(container: Container, mainFactory: IMainFactory) {
        self.container = container
        self.mainFactory = mainFactory
    }

    func register() {
        container.register(INetwork.self) { _ in
            Network()
        }.inObjectScope(.container)
    }
}

// MARK: - INetworkFactory

extension NetworkFactory: INetworkFactory {
    func networkInitializer() -> INetworkInitializer {
        return network() as INetworkInitializer
    }

    func networkData() -> INetworkData {
        return network() as INetworkData
    }
}

// MARK: - Private

private extension NetworkFactory {
    func network() -> INetwork {
        return container.resolve(INetwork.self)!
    }
}
