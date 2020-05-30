//
//  AddTVShowInteractor.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IAddTVShowInteractor {
}

class AddTVShowInteractor {
    let presenter: IAddTVShowPresenter

    init(presenter: IAddTVShowPresenter) {
        self.presenter = presenter
    }
}

// MARK: - IAddTVShowInteractor

extension AddTVShowInteractor: IAddTVShowInteractor {
    
}
