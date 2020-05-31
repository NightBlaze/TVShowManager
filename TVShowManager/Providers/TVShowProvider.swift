//
//  TVShowProvider.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol ITVShowProvider: ITVShowProviderCreator {
}

protocol ITVShowProviderCreator {
    func createTVShow(title: String, year: Int, seasons: Int) -> TVShowDAO
}

final class TVShowProvider: ITVShowProvider {
    private let lps: ILocalPersistentStoreContext

    init(lps: ILocalPersistentStoreContext) {
        self.lps = lps
    }
}

// MARK: - ITVShowProviderCreator

extension TVShowProvider: ITVShowProviderCreator {
    @discardableResult
    func createTVShow(title: String, year: Int, seasons: Int) -> TVShowDAO {
        let tvShow = TVShowDAO.create(title: title, year: Int32(year), seasons: Int32(seasons), context: lps.backgroundContext)
        lps.save()
        return tvShow
    }
}
