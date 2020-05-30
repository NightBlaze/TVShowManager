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
}

final class ViewControllersFactory: IFactory {
    private let container: Container
    private let mainFactory: IMainFactory

    init(container: Container, mainFactory: IMainFactory) {
        self.container = container
        self.mainFactory = mainFactory
    }

    func register() {
        container.register(IAddTVShowViewController.self) { _ in
            let presenter = AddTVShowPresenter()
            let interactor = AddTVShowInteractor(presenter: presenter)
            let viewController = AddTVShowViewController(interactor: interactor)
            presenter.resolveDependencies(viewController: viewController)

            return viewController
        }

        container.register(IAppStartViewController.self) { [unowned self] _ in
            let presenter = AppStartViewControllerPresenter()
            let lps = self.mainFactory.dataLayerFactory().localPersistentStoreInitializer()
            let interactor = AppStartViewControllerInteractor(presenter: presenter, localPersistentStore: lps)
            let viewController = AppStartViewController(interactor: interactor, viewControllersFactory: self)
            presenter.resolveDependencies(viewController: viewController)

            return viewController
        }

        container.register(IHomeViewController.self) { _ in
            let presenter = HomeViewControllerPresenter()
            let interactor = HomeViewControllerInteractor(presenter: presenter)
            let viewController = HomeViewController(interactor: interactor)
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
}
