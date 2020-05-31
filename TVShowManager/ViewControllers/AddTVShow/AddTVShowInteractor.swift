//
//  AddTVShowInteractor.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IAddTVShowInteractor {
    func createTVShow(title: String?, year: String?, seasons: String?)
    func isDataValid(title: String?, year: String?, seasons: String?) -> Bool
}

final class AddTVShowInteractor {
    private let presenter: IAddTVShowPresenter
    private let tvShowProvider: ITVShowProviderCreator

    init(presenter: IAddTVShowPresenter,
         tvShowProvider: ITVShowProviderCreator) {
        self.presenter = presenter
        self.tvShowProvider = tvShowProvider
    }
}

// MARK: - IAddTVShowInteractor

extension AddTVShowInteractor: IAddTVShowInteractor {
    func createTVShow(title: String?, year: String?, seasons: String?) {
        guard let title = title,
            let year = year,
            let yearInt = Int(year),
            let seasons = seasons,
            let seasonsInt = Int(seasons),
            isDataValid(title: title, year: year, seasons: seasons) else {
            self.presenter.addTVShowFailed()
            return
        }

        tvShowProvider.createTVShow(title: title, year: yearInt, seasons: seasonsInt) { [weak self] result in
            switch result {
            case .success(_):
                self?.presenter.addTVShowSuccessed()
            case .failure(_):
                self?.presenter.addTVShowFailed()
            }
        }
    }

    func isDataValid(title: String?, year: String?, seasons: String?) -> Bool {
        guard let title = title,
            title.count > 0,
            let year = year,
            let yearInt = Int(year),
            yearInt > 0,
            let seasons = seasons,
            let seasonsInt = Int(seasons),
            seasonsInt > 0 else {
                return false
        }

        return true
    }
}
