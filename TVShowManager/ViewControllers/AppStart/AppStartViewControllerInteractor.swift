//
//  AppStartViewControllerInteractor.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IAppStartViewControllerInteractor {
    func initializeApplication()
}

final class AppStartViewControllerInteractor {
    let presenter: IAppStartViewControllerPresenter
    let lps: ILocalPersistentStoreInitializer

    init(presenter: IAppStartViewControllerPresenter,
         localPersistentStore: ILocalPersistentStoreInitializer) {
        self.presenter = presenter
        lps = localPersistentStore
    }
}

// MARK: - IAppStartViewControllerInteractor

extension AppStartViewControllerInteractor: IAppStartViewControllerInteractor {
    func initializeApplication() {
        lps.initializeLPS { [weak self] result in
            switch result {
            case .success(_):
                self?.presenter.initializationSuccessed()
            case .failure(_):
                self?.presenter.initializationFailed()
            }
        }
    }
}
