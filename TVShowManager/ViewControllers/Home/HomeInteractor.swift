//
//  HomeInteractor.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IHomeInteractor {
    // It's not a responsobility of Home screen
    // But because the screen is the main screen and it'll 100% exists
    // after application initialized and because it's a case study
    // I've decided to leave here downloading all TV shows from a server
    func fetchTVShows()
}

final class HomeInteractor {
    private let presenter: IHomePresenter
    private let tvShowProvider: ITVShowProviderData

    init(presenter: IHomePresenter,
         tvShowProvider: ITVShowProviderData) {
        self.presenter = presenter
        self.tvShowProvider = tvShowProvider
    }
}

// MARK: - IHomeInteractor

extension HomeInteractor: IHomeInteractor {
    func fetchTVShows() {
        tvShowProvider.fetchAndSaveAllTVShowsFromServer()
    }
}
