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
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.addSubview(titleLabel)
        backgroundColor = .systemGray2
    }

    private func setupConstraints() {
        titleLabel.fillSuperview()
    }
}
