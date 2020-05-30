//
//  HomeViewControllerInteractor.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IHomeViewControllerInteractor {
}

class HomeViewControllerInteractor {
    let presenter: IHomeViewControllerPresenter

    init(presenter: IHomeViewControllerPresenter) {
        self.presenter = presenter
    }
}

// MARK: - IHomeViewControllerInteractor

extension HomeViewControllerInteractor: IHomeViewControllerInteractor {

}
