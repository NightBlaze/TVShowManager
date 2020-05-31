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
    private let presenter: IAppStartPresenter
    private let network: INetworkInitializer
    private let lps: ILocalPersistentStoreInitializer

    init(presenter: IAppStartPresenter,
         network: INetworkInitializer,
         localPersistentStore: ILocalPersistentStoreInitializer) {
        self.presenter = presenter
        self.network = network
        lps = localPersistentStore
    }
}

// MARK: - IAppStartInteractor

extension AppStartInteractor: IAppStartInteractor {
    func initializeApplication() {
        network.initialize()
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
