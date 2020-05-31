//
//  HomeInteractor.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IHomeInteractor {
}

final class HomeInteractor {
    private let presenter: IHomePresenter

    init(presenter: IHomePresenter) {
        self.presenter = presenter
    }
}

// MARK: - IHomeInteractor

extension HomeInteractor: IHomeInteractor {

}
