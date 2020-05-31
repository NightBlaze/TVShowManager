//
//  AddTVShowPresenter.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IAddTVShowPresenter {
}

final class AddTVShowPresenter {
    private weak var viewController: IAddTVShowViewController?

    func resolveDependencies(viewController: IAddTVShowViewController) {
        self.viewController = viewController
    }
}

// MARK: - IAddTVShowPresenter

extension AddTVShowPresenter: IAddTVShowPresenter {
}
