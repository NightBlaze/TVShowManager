//
//  ViewControllersFactory.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation
import Swinject

protocol IViewControllersFactory: IFactory {
    func addTVShowViewController() -> IAddTVShowViewController
    func appStartViewController() -> IAppStartViewController
    func homeViewController() -> IHomeViewController
    func watchedTVShowViewController() -> IWatchedTVShowViewController
}

final class ViewControllersFactory: IFactory {
    private let container: Container
    private let mainFactory: IMainFactory

    init(container: Container, mainFactory: IMainFactory) {
        self.container = container
        self.mainFactory = mainFactory
    }

    func register() {
        container.register(IAddTVShowViewController.self) { [unowned self] _ in
            let presenter = AddTVShowPresenter()
            let provider = self.mainFactory.providersFactory().tvShowProviderCreator()
            let interactor = AddTVShowInteractor(presenter: presenter, tvShowProvider: provider)
            let routerScenario = self.mainFactory.routerFactory().homeRouterScenario()
            let viewController = AddTVShowViewController(interactor: interactor, router: routerScenario)
            presenter.resolveDependencies(viewController: viewController)

            return viewController
        }

        container.register(IAppStartViewController.self) { [unowned self] _ in
            let presenter = AppStartPresenter()
            let network = self.mainFactory.networkFactory().networkInitializer()
            let lps = self.mainFactory.dataLayerFactory().localPersistentStoreInitializer()
            let interactor = AppStartInteractor(presenter: presenter, network: network, localPersistentStore: lps)
            let routerScenario = self.mainFactory.routerFactory().appStartRouterScenario()
            let viewController = AppStartViewController(interactor: interactor, routerScenario: routerScenario)
            presenter.resolveDependencies(viewController: viewController)

            return viewController
        }

        container.register(IHomeViewController.self) { _ in
            let presenter = HomePresenter()
            let interactor = HomeInteractor(presenter: presenter)
            let routerScenario = self.mainFactory.routerFactory().homeRouterScenario()
            let viewController = HomeViewController(interactor: interactor, router: routerScenario)
            presenter.resolveDependencies(viewController: viewController)

            return viewController
        }

        container.register(IWatchedTVShowViewController.self) { _ in
            let presenter = WatchedTVShowPresenter()
            let providerData = self.mainFactory.providersFactory().tvShowProviderData()
            let providerCreator = self.mainFactory.providersFactory().tvShowProviderCreator()
            let interactor = WatchedTVShowInteractor(presenter: presenter,
                                                     tvShowProviderData: providerData,
                                                     tvShowProviderCreator: providerCreator)
            let viewController = WatchedTVShowViewController(interactor: interactor)
            presenter.resolveDependencies(viewController: viewController)

            return viewController
        }
    }
}

// MARK: - IViewControllersFactory

extension ViewControllersFactory: IViewControllersFactory {
    func addTVShowViewController() -> IAddTVShowViewController {
        return container.resolve(IAddTVShowViewController.self)!
    }

    func appStartViewController() -> IAppStartViewController {
        return container.resolve(IAppStartViewController.self)!
    }

    func homeViewController() -> IHomeViewController {
        return container.resolve(IHomeViewController.self)!
    }

    func watchedTVShowViewController() -> IWatchedTVShowViewController {
        return container.resolve(IWatchedTVShowViewController.self)!
    }
}
