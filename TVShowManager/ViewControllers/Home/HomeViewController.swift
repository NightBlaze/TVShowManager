//
//  HomeViewController.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

protocol IHomeViewController: UIViewController {
}

final class HomeViewController: UIViewController {
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var addTVShowButton: ActionButton!
    @IBOutlet weak var showTVShowButton: ActionButton!
    
    private let interactor: IHomeInteractor
    private let routerScenario: IHomeRouterScenario

    init(interactor: IHomeInteractor,
         router: IHomeRouterScenario) {
        self.interactor = interactor
        routerScenario = router
        super.init(nibName: HomeViewController.nameOfClass(), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "home_view_controller.title".localized

        addTVShowButton.setTitle("home_view_controller.add_tv_show_button.title".localized, for: .normal)
        showTVShowButton.setTitle("home_view_controller.show_tv_show_button.title".localized, for: .normal)

        topImageView.layer.applyDefaultCornerRadius()
    }
}

// MARK: - IHomeViewController

extension HomeViewController: IHomeViewController {

}

// MARK: - IBActions

private extension HomeViewController {
    @IBAction func addTVShowButtonDidPress(_ sender: Any) {
        routerScenario.goToAddTVShow(from: self)
    }

    @IBAction func showTVShowButtonDidPress(_ sender: Any) {
        routerScenario.goToWatchedTVShow(from: self)
    }
}
