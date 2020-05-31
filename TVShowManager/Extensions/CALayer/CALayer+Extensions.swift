//
//  CALayer+Extensions.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

extension CALayer {
    private static var defaultCornerRadius: CGFloat { 16.0 }

    @discardableResult
    func applyCornerRadius(_ radius: CGFloat) -> Self {
        cornerRadius = radius
        return self
    }

    @discardableResult
    func applyDefaultCornerRadius() -> Self {
        return applyCornerRadius(CALayer.defaultCornerRadius)
    }
}
