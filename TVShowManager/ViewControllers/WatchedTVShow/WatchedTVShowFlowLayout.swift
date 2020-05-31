//
//  WatchedTVShowFlowLayout.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

// from https://littlebitesofcocoa.com/306-customizing-collection-view-cell-insertion-animations
final class WatchedTVShowFlowLayout: UICollectionViewFlowLayout {
    private var insertingIndexPaths: [IndexPath] = []

    var collectionViewWidth: CGFloat = 0 {
        didSet {
            if collectionViewWidth != oldValue {
                itemSize = CGSize(width: collectionViewWidth - sectionInset.left - sectionInset.right,
                                  height: WatchedTVShowCollectionViewCell.height)
            }
        }
    }

    override init() {
        super.init()

        sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)

        insertingIndexPaths.removeAll()

        updateItems.forEach { updateItem in
            if let indexPath = updateItem.indexPathAfterUpdate,
                updateItem.updateAction == .insert {
              insertingIndexPaths.append(indexPath)
            }
        }
    }

    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()

        insertingIndexPaths.removeAll()
    }

    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)

        if insertingIndexPaths.contains(itemIndexPath) {
            attributes?.alpha = 0.0
            attributes?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }

        return attributes
    }
}
