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

class HomeViewController: UIViewController {
    let interactor: IHomeViewControllerInteractor

    init(interactor: IHomeViewControllerInteractor) {
        self.interactor = interactor
        super.init(nibName: HomeViewController.nameOfClass(), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - IHomeViewController

extension HomeViewController: IHomeViewController {

}
