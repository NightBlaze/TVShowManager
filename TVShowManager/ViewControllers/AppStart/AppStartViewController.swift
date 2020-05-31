//
//  AppStartViewController.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

protocol IAppStartViewController: UIViewController {
    func showError(viewModel: AppStartViewModel)
    func goToHomeViewController()
}

final class AppStartViewController: UIViewController {
    @IBOutlet weak var infoLabel: UILabel!

    private let interactor: IAppStartInteractor
    private let routerScenario: IAppStartRouterScenario

    init(interactor: IAppStartInteractor,
         routerScenario: IAppStartRouterScenario) {
        self.interactor = interactor
        self.routerScenario = routerScenario
        super.init(nibName: AppStartViewController.nameOfClass(), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        infoLabel.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        interactor.initializeApplication()
    }
}

// MARK: - IAppStartViewController

extension AppStartViewController: IAppStartViewController {
    func showError(viewModel: AppStartViewModel) {
        infoLabel.text = viewModel.errorMessage
        infoLabel.isHidden = false
    }

    func goToHomeViewController() {
        routerScenario.goToHome()
    }
}
