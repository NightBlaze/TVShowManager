//
//  WatchedTVShowInteractor.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IWatchedTVShowInteractor {
}

class WatchedTVShowInteractor {
    let presenter: IWatchedTVShowPresenter

    init(presenter: IWatchedTVShowPresenter) {
        self.presenter = presenter
    }
}

// MARK: - IWatchedTVShowInteractor

extension WatchedTVShowInteractor: IWatchedTVShowInteractor {
    
}
