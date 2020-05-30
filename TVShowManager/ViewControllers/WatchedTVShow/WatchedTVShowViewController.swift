//
//  WatchedTVShowViewController.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

protocol IWatchedTVShowViewController: UIViewController {
}

class WatchedTVShowViewController: UIViewController {
    let interactor: IWatchedTVShowInteractor

    init(interactor: IWatchedTVShowInteractor) {
        self.interactor = interactor
        super.init(nibName: WatchedTVShowViewController.nameOfClass(), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - IWatchedTVShowViewController

extension WatchedTVShowViewController: IWatchedTVShowViewController {
}
