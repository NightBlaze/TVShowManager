//
//  Router.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

protocol IRouter: IAppStartRouterScenario, IHomeRouterScenario {
}

protocol IAppStartRouterScenario {
    func goToHome()
}

protocol IHomeRouterScenario {
    func goToAddTVShow(from: UIViewController)
    func goToWatchedTVShow(from: UIViewController)
}

final class Router: IRouter {
    private let viewControllersFactory: IViewControllersFactory

    init(viewControllersFactory: IViewControllersFactory) {
        self.viewControllersFactory = viewControllersFactory
    }
}

// MARK: - IAppStartRouterScenario

extension Router: IAppStartRouterScenario {
    func goToHome() {
        let homeViewController = viewControllersFactory.homeViewController().encapsulateInNavigationController()
        setRootViewController(viewController: homeViewController)
    }
}

// MARK: - IHomeRouterScenario

extension Router: IHomeRouterScenario {
    func goToAddTVShow(from: UIViewController) {
        let viewController = viewControllersFactory.addTVShowViewController()
        from.navigationController?.pushViewController(viewController, animated: true)
        push(viewController: viewController, from: from)
    }

    func goToWatchedTVShow(from: UIViewController) {
        let viewController = viewControllersFactory.watchedTVShowViewController()
        push(viewController: viewController, from: from)
    }
}

// MARK: - Private

private extension Router {
    func setRootViewController(viewController: UIViewController, forWindow: UIWindow? = nil) {
        viewController.setAsRootWindow(for: forWindow)
    }

    func push(viewController: UIViewController,
              from: UIViewController,
              animated: Bool = true) {
        from.navigationController?.pushViewController(viewController, animated: animated)
    }
}
