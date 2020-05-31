//
//  WatchedTVShowCellViewModel.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

struct WatchedTVShowCellViewModel {
    let title: String
    let year: String
    let seasons: String

    init(dao: TVShowDAO) {
        title = dao.title ?? ""
        year = "\(dao.year)"
        seasons = "\(dao.seasons)"
    }
}
