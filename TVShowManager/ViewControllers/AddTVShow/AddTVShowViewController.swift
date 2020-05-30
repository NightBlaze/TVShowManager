//
//  AddTVShowViewController.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

protocol IAddTVShowViewController: UIViewController {
}

class AddTVShowViewController: UIViewController {
    let interactor: IAddTVShowInteractor

    init(interactor: IAddTVShowInteractor) {
        self.interactor = interactor
        super.init(nibName: AddTVShowViewController.nameOfClass(), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - IAddTVShowViewController

extension AddTVShowViewController: IAddTVShowViewController {
}