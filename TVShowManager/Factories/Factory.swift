//
//  Factory.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import Swinject

protocol IFactory {
    func register()
}

protocol IMainFactory: IFactory {
    func dataLayerFactory() -> IDataLayerFactory
    func networkFactory() -> INetworkFactory
    func providersFactory() -> IProvidersFactory
    func routerFactory() -> IRouterFactory
    func viewControllersFactory() -> IViewControllersFactory
}

final class Factory: IFactory {
    private let container = Container()

    func register() {
        container.register(IDataLayerFactory.self) { [unowned self] _ in
            DataLayerFactory(container: self.container, mainFactory: self)
        }.inObjectScope(.container)

        container.register(INetworkFactory.self) { [unowned self] _ in
            NetworkFactory(container: self.container, mainFactory: self)
        }.inObjectScope(.container)

        container.register(IProvidersFactory.self) { [unowned self] _ in
            ProvidersFactory(container: self.container, mainFactory: self)
        }.inObjectScope(.container)

        container.register(IRouterFactory.self) { [unowned self] _ in
            RouterFactory(container: self.container, mainFactory: self)
        }.inObjectScope(.container)

        container.register(IViewControllersFactory.self) { [unowned self] _ in
            ViewControllersFactory(container: self.container, mainFactory: self)
        }.inObjectScope(.container)

        registerOther()
    }

    private func registerOther() {
        dataLayerFactory().register()
        networkFactory().register()
        providersFactory().register()
        routerFactory().register()
        viewControllersFactory().register()
    }
}

// MARK: - IMainFactory

extension Factory: IMainFactory {
    func dataLayerFactory() -> IDataLayerFactory {
        return container.resolve(IDataLayerFactory.self)!
    }

    func networkFactory() -> INetworkFactory {
        return container.resolve(INetworkFactory.self)!
    }

    func providersFactory() -> IProvidersFactory {
        return container.resolve(IProvidersFactory.self)!
    }

    func routerFactory() -> IRouterFactory {
        return container.resolve(IRouterFactory.self)!
    }

    func viewControllersFactory() -> IViewControllersFactory {
        return container.resolve(IViewControllersFactory.self)!
    }
}
