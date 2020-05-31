//
//  HomePresenter.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IHomePresenter {
}

class HomePresenter {
    weak var viewController: IHomeViewController?

    func resolveDependencies(viewController: IHomeViewController) {
        self.viewController = viewController
    }
}

// MARK: - IHomePresenter

extension HomePresenter: IHomePresenter {
}
