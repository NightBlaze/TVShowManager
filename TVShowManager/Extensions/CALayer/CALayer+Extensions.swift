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

    @discardableResult
    func applyShadow(color: UIColor,
                     offset: CGSize,
                     opacity: Float,
                     radius: CGFloat,
                     rasterize: Bool) -> Self {
        self.masksToBounds = false
        self.shadowColor = color.cgColor
        self.shadowOffset = offset
        self.shadowOpacity = opacity
        self.shadowRadius = radius
        self.shouldRasterize = rasterize
        self.rasterizationScale = UIScreen.main.scale
        return self
    }

    @discardableResult
    func applyDefaultShadow() -> Self {
        return self.applyShadow(color: .black,
                                offset: .zero,
                                opacity: 0.2,
                                radius: 2,
                                rasterize: true)
    }
}
