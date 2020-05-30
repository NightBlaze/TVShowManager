//
//  Router.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

protocol IRouter: IWindowRouter, IHomeRouterScenario {
}

protocol IWindowRouter {
    func setRootViewController(viewController: UIViewController, forWindow: UIWindow?)
}

protocol IHomeRouterScenario {
    func goToAddTVShow(from: UIViewController)
    func goToWatchedTVShow(from: UIViewController)
}

class Router: IRouter {
    let viewControllersFactory: IViewControllersFactory

    init(viewControllersFactory: IViewControllersFactory) {
        self.viewControllersFactory = viewControllersFactory
    }
}

// MARK: - IWindowRouter

extension Router: IWindowRouter {
    func setRootViewController(viewController: UIViewController, forWindow: UIWindow?) {
        var window = forWindow
        if window == nil {
            window = UIApplication.shared.windows.filter { !$0.isHidden }.first
        }
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
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
    func push(viewController: UIViewController,
              from: UIViewController,
              animated: Bool = true) {
        from.navigationController?.pushViewController(viewController, animated: animated)
    }
}
