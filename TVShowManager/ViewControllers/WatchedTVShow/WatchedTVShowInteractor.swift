//
//  WatchedTVShowInteractor.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IWatchedTVShowInteractor {
    func loadSavedData()
    func addFakeTVShow()
}

final class WatchedTVShowInteractor {
    private let presenter: IWatchedTVShowPresenter
    private let tvShowProviderData: ITVShowProviderData
    private let tvShowProviderCreator: ITVShowProviderCreator

    init(presenter: IWatchedTVShowPresenter,
         tvShowProviderData: ITVShowProviderData,
         tvShowProviderCreator: ITVShowProviderCreator) {
        self.presenter = presenter
        self.tvShowProviderData = tvShowProviderData
        self.tvShowProviderCreator = tvShowProviderCreator

        self.tvShowProviderData.addListener(self)
    }

    deinit {
        tvShowProviderData.removeListener(self)
    }
}

// MARK: - IWatchedTVShowInteractor

extension WatchedTVShowInteractor: IWatchedTVShowInteractor {
    func loadSavedData() {
        let tvShows = tvShowProviderData.savedTVShows()
        presenter.updateAll(tvShows: tvShows)
    }

    func addFakeTVShow() {
        tvShowProviderCreator.createTVShow(title: String(UUID().uuidString.prefix(8)),
                                           year: Int.random(in: 1980...2020),
                                           seasons: Int.random(in: 1...5)) { _ in }
    }
}

// MARK: - ITVShowProviderDataUpdateListener

extension WatchedTVShowInteractor: ITVShowProviderDataUpdateListener {
    func tvShowAdded(tvShow: TVShowDAO) {
        presenter.add(tvShow: tvShow)
    }
}
