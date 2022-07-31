//
//  HomeViewController.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import UIKit

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModelInput
    private let contentView = HomeView()
    private var tvShows = [TVShow]()

    init(viewModel: HomeViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TV Shows"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.listTVShows()
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
    }
}

extension HomeViewController: HomeViewModelOutput {
    func presentShows(_ tvShows: [TVShow]) {
        self.tvShows = tvShows
        contentView.collectionView.reloadData()
    }

    func presentLoading(_ isLoading: Bool) {
        contentView.isLoading = isLoading
    }

    func presentAlert(_ alert: AlertViewModel) {
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: alert.button, style: .default)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tvShows.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = tvShows[indexPath.item]
        return contentView.configureTVShowCell(for: indexPath, with: model)
    }
}
