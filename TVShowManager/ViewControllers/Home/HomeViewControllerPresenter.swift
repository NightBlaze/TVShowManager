//
//  HomeViewControllerPresenter.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IHomeViewControllerPresenter {
}

class HomeViewControllerPresenter {
    weak var viewController: IHomeViewController?

    func resolveDependencies(viewController: IHomeViewController) {
        self.viewController = viewController
    }
}

// MARK: - IHomeViewControllerPresenter

extension HomeViewControllerPresenter: IHomeViewControllerPresenter {
}
