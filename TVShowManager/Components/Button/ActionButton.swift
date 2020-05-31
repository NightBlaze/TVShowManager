//
//  ActionButton.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
    private static var defaultEdgeInsets: UIEdgeInsets { UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16) }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Private

private extension ActionButton {
    func setupUI() {
        layer.applyDefaultCornerRadius()
        contentEdgeInsets = ActionButton.defaultEdgeInsets
    }
}
