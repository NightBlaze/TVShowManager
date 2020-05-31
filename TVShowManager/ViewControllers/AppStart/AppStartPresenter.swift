//
//  AppStartPresenter.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IAppStartPresenter {
    func initializationSuccessed()
    func initializationFailed()
}

final class AppStartPresenter {
    weak var viewController: IAppStartViewController?

    func resolveDependencies(viewController: IAppStartViewController) {
        self.viewController = viewController
    }
}

// MARK: - IAppStartPresenter

extension AppStartPresenter: IAppStartPresenter {
    func initializationSuccessed() {
        viewController?.goToHomeViewController()
    }

    func initializationFailed() {
        let viewModel = AppStartViewModel(errorMessage: "app_start_view_controller.app_initialization.error".localized)
        viewController?.showError(viewModel: viewModel)
    }
}
