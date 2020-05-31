//
//  UICollectionViewCell+Creating.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 31.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    class func reuseIdentifier() -> String {
        return nameOfClass()
    }

    class func nib() -> UINib? {
        let name = nameOfClass()
        return UINib(nibName: name, bundle: nil)
    }

    class func registerClass(for collectionView: UICollectionView?) {
        collectionView?.register(self, forCellWithReuseIdentifier: reuseIdentifier())
    }

    class func registerNib(for collectionView: UICollectionView?) {
        collectionView?.register(nib(), forCellWithReuseIdentifier: reuseIdentifier())
    }

    class func dequeue(for collectionView: UICollectionView,
                       indexPath: IndexPath) -> Self {
        return dequeCell(for: collectionView, indexPath: indexPath)
    }
}

// MARK: - Private

private extension UICollectionViewCell {
    class func dequeCell<T: UICollectionViewCell>(for collectionView: UICollectionView,
                                                  indexPath: IndexPath) -> T {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier(), for: indexPath) as! T
        return cell
    }
}
