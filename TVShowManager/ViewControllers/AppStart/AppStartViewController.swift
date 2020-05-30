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

class AppStartViewController: UIViewController {
    @IBOutlet weak var infoLabel: UILabel!

    let interactor: IAppStartViewControllerInteractor
    let viewControllersFactory: IViewControllersFactory

    init(interactor: IAppStartViewControllerInteractor,
         viewControllersFactory: IViewControllersFactory) {
        self.interactor = interactor
        self.viewControllersFactory = viewControllersFactory
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
        let homeViewController = viewControllersFactory.homeViewController().encapsulateInNavigationController()
        homeViewController.setAsRootWindow()
    }
}
