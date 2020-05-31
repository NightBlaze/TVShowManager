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
    private static var activeBackgroundColor: UIColor { .systemBlue }
    private static var disabledBackgroundColor: UIColor { .systemGray }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? ActionButton.activeBackgroundColor : ActionButton.disabledBackgroundColor
        }
    }
}

// MARK: - Private

private extension ActionButton {
    func setupUI() {
        layer.applyDefaultCornerRadius()
        contentEdgeInsets = ActionButton.defaultEdgeInsets
        backgroundColor = ActionButton.activeBackgroundColor
        setTitleColor(.white, for: .normal)
        setTitleColor(.black, for: .disabled)
    }
}
