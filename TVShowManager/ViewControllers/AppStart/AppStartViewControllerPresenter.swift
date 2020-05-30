//
//  AppStartViewControllerPresenter.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IAppStartViewControllerPresenter {
    func initializationSuccessed()
    func initializationFailed()
}

final class AppStartViewControllerPresenter {
    weak var viewController: IAppStartViewController?

    func resolveDependencies(viewController: IAppStartViewController) {
        self.viewController = viewController
    }
}

// MARK: - IAppStartViewControllerPresenter

extension AppStartViewControllerPresenter: IAppStartViewControllerPresenter {
    func initializationSuccessed() {
        viewController?.goToHomeViewController()
    }

    func initializationFailed() {
        let viewModel = AppStartViewModel(errorMessage: "Error initialize application")
        viewController?.showError(viewModel: viewModel)
    }
}
