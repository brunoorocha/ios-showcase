//
//  TVShowCollectionViewCell.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import UIKit

final class TVShowCollectionViewCell: UICollectionViewCell, Reusable {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .white
        label.shadowColor = .black.withAlphaComponent(0.4)
        label.shadowOffset = .init(width: 1, height: 1)
        return label
    }()
    
    var coverImageView = AsyncImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemGray2
    }

    private func setupConstraints() {
        coverImageView.fillSuperview()

        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
