//
//  WatchedTVShowCollectionViewCell.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

class WatchedTVShowCollectionViewCell: UICollectionViewCell {
    static var height: CGFloat { 123 }

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var seasonsLabel: UILabel!

    private var shadowLayer: CAShapeLayer!

    private var viewModel: WatchedTVShowCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            yearLabel.text = "watched_tv_show_cell.year".localized + " " + (viewModel?.year ?? "")
            seasonsLabel.text = "watched_tv_show_cell.seasons".localized + " " + (viewModel?.seasons ?? "")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.layer.applyDefaultShadow()
        containerView.layer.applyDefaultCornerRadius()
    }

    func update(viewModel: WatchedTVShowCellViewModel?) {
        self.viewModel = viewModel
    }
}
