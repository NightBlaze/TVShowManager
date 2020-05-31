//
//  AppStartInteractor.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IAppStartInteractor {
    func initializeApplication()
}

final class AppStartInteractor {
    let presenter: IAppStartPresenter
    let lps: ILocalPersistentStoreInitializer

    init(presenter: IAppStartPresenter,
         localPersistentStore: ILocalPersistentStoreInitializer) {
        self.presenter = presenter
        lps = localPersistentStore
    }
}

// MARK: - IAppStartInteractor

extension AppStartInteractor: IAppStartInteractor {
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
