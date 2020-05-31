//
//  WatchedTVShowPresenter.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IWatchedTVShowPresenter {
    func updateAll(tvShows: [TVShowDAO]?)
    func add(tvShow: TVShowDAO)
}

final class WatchedTVShowPresenter {
    private weak var viewController: IWatchedTVShowViewController?

    func resolveDependencies(viewController: IWatchedTVShowViewController) {
        self.viewController = viewController
    }
}

// MARK: - IWatchedTVShowPresenter

extension WatchedTVShowPresenter: IWatchedTVShowPresenter {
    func updateAll(tvShows: [TVShowDAO]?) {
        let viewModels = tvShows?.map { WatchedTVShowCellViewModel(dao: $0) }
        viewController?.setViewModels(viewModels ?? [])
    }

    func add(tvShow: TVShowDAO) {
        let viewModel = WatchedTVShowCellViewModel(dao: tvShow)
        viewController?.add(viewModel: viewModel)
    }
}
