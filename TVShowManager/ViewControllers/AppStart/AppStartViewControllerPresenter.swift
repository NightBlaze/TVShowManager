//
//  AppStartViewControllerPresenter.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IAppStartViewControllerPresenter {
}

final class AppStartViewControllerPresenter {
    weak var viewController: IAppStartViewController?

    func resolveDependencies(viewController: IAppStartViewController) {
        self.viewController = viewController
    }
}

// MARK: - IAppStartViewControllerPresenter

extension AppStartViewControllerPresenter: IAppStartViewControllerPresenter {
}
