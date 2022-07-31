//
//  HomeView.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import UIKit

final class HomeView: UIView {
    private var loadingView = LoadingView()
    
    var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: HomeCollectionViewLayout(numberOfColumns: 2, containerWidth: UIScreen.main.bounds.width)
    )

    var isLoading = false {
        didSet {
            if isLoading {
                loadingView.startAnimating()
                return
            }
            loadingView.stopAnimating()
        }
    }

    init() {
        super.init(frame: .zero)
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        collectionView.register(TVShowCollectionViewCell.self)
        addSubview(collectionView)
        addSubview(loadingView)
        backgroundColor = .systemBackground
    }

    private func setupConstraints() {
        loadingView.fillSuperview()
        collectionView.fillSuperview()
    }

    func configureTVShowCell(for indexPath: IndexPath, with model: TVShow) -> TVShowCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.reusableIdentifier, for: indexPath) as? TVShowCollectionViewCell else {
            fatalError()
        }
        cell.titleLabel.text = model.title
        return cell
    }
}
