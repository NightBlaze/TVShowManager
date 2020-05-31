//
//  AddTVShowPresenter.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import Foundation

protocol IAddTVShowPresenter {
    func addTVShowSuccessed()
    func addTVShowFailed()
}

final class AddTVShowPresenter {
    private weak var viewController: IAddTVShowViewController?

    func resolveDependencies(viewController: IAddTVShowViewController) {
        self.viewController = viewController
    }
}

// MARK: - IAddTVShowPresenter

extension AddTVShowPresenter: IAddTVShowPresenter {
    func addTVShowSuccessed() {
        viewController?.goBack()
    }

    func addTVShowFailed() {
        let viewModel = TVShowViewModel(errorTitle: "add_tv_show_view_controller.add_tv_show.error_title".localized,
                                        errorMessage: "add_tv_show_view_controller.add_tv_show.error_message".localized)
        viewController?.showError(viewModel: viewModel)
    }
}
