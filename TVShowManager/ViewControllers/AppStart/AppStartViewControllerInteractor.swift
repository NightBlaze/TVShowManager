//
//  AppStartViewControllerInteractor.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IAppStartViewControllerInteractor {
}

final class AppStartViewControllerInteractor {
    let presenter: IAppStartViewControllerPresenter

    init(presenter: IAppStartViewControllerPresenter) {
        self.presenter = presenter
    }
}

// MARK: - IAppStartViewControllerInteractor

extension AppStartViewControllerInteractor: IAppStartViewControllerInteractor {
}
