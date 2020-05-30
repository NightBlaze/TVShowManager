//
//  WatchedTVShowPresenter.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IWatchedTVShowPresenter {
}

class WatchedTVShowPresenter {
    weak var viewController: IWatchedTVShowViewController?

    func resolveDependencies(viewController: IWatchedTVShowViewController) {
        self.viewController = viewController
    }
}

// MARK: - IWatchedTVShowPresenter

extension WatchedTVShowPresenter: IWatchedTVShowPresenter {
}
