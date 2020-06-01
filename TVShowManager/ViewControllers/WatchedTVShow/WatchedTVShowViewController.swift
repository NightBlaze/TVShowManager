//
//  WatchedTVShowViewController.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

protocol IWatchedTVShowViewController: UIViewController {
    func setViewModels(_ viewModels: [WatchedTVShowCellViewModel])
    func add(viewModel: WatchedTVShowCellViewModel)
}

final class WatchedTVShowViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let collectionViewLayout = WatchedTVShowFlowLayout()

    private let interactor: IWatchedTVShowInteractor
    private var viewModels: [WatchedTVShowCellViewModel] = []

    init(interactor: IWatchedTVShowInteractor) {
        self.interactor = interactor
        super.init(nibName: WatchedTVShowViewController.nameOfClass(), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "watched_tv_show_view_controller.title".localized

        let addTVShowBarButtonItem = UIBarButtonItem(title: "watched_tv_show_view_controller.add_tv_show_button.title".localized,
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(addButtonDidPress(_:)))
        let questionBarButtonItem = UIBarButtonItem(title: "watched_tv_show_view_controller.question_mark.title".localized,
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(questionButtonDidPress(_:)))
        navigationItem.rightBarButtonItems = [questionBarButtonItem, addTVShowBarButtonItem]

        WatchedTVShowCollectionViewCell.registerNib(for: collectionView)

        collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
        collectionView.dataSource = self

        interactor.loadSavedData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        collectionViewLayout.collectionViewWidth = collectionView.bounds.size.width
    }
}

// MARK: - IWatchedTVShowViewController

extension WatchedTVShowViewController: IWatchedTVShowViewController {
    func setViewModels(_ viewModels: [WatchedTVShowCellViewModel]) {
        self.viewModels = viewModels
        collectionView.reloadData()
    }

    func add(viewModel: WatchedTVShowCellViewModel) {
        viewModels.insert(viewModel, at: 0)

        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: [indexPath])
        })
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension WatchedTVShowViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = WatchedTVShowCollectionViewCell.dequeue(for: collectionView, indexPath: indexPath)
        cell.update(viewModel: viewModels.safeItem(at: indexPath.row))
        return cell
    }
}

// MARK: - Private

private extension WatchedTVShowViewController {
    @objc func addButtonDidPress(_ sender: Any) {
        interactor.addFakeTVShow()
    }

    @objc func questionButtonDidPress(_ sender: Any) {
        showSimpleAlert(title: "", message: "watched_tv_show_view_controller.simulate.about".localized)
    }
}
