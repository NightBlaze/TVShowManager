//
//  AppStartViewController.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

protocol IAppStartViewController: UIViewController {
}

class AppStartViewController: UIViewController {
    let interactor: IAppStartViewControllerInteractor

    init(interactor: IAppStartViewControllerInteractor) {
        self.interactor = interactor
        super.init(nibName: AppStartViewController.nameOfClass(), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        interactor.initializeApplication()
    }
}

// MARK: - IAppStartViewController

extension AppStartViewController: IAppStartViewController {
}
