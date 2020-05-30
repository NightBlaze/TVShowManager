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
    func appStartViewController() -> IAppStartViewController
}

final class ViewControllersFactory: IFactory {
    private let container: Container
    private let mainFactory: IMainFactory

    init(container: Container, mainFactory: IMainFactory) {
        self.container = container
        self.mainFactory = mainFactory
    }

    func register() {
        container.register(IAppStartViewController.self) { _ in
            let presenter = AppStartViewControllerPresenter()
            let interactor = AppStartViewControllerInteractor(presenter: presenter)
            let viewController = AppStartViewController(interactor: interactor)
            presenter.resolveDependencies(viewController: viewController)

            return viewController
        }
    }
}

// MARK: - IViewControllersFactory

extension ViewControllersFactory: IViewControllersFactory {
    func appStartViewController() -> IAppStartViewController {
        return container.resolve(IAppStartViewController.self)!
    }
}
