//
//  UIViewController+Routing.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

extension UIViewController {
    func setAsRoot(forWindow window: UIWindow) {
        window.rootViewController = self
        window.makeKeyAndVisible()
    }
}
