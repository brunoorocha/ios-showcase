//
//  TVShowDetailsView.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 31/07/22.
//

import UIKit

final class TVShowDetailsView: UIView {
    init() {
        super.init(frame: .zero)
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
    }
    
    private func setupConstraints() {
        
    }
}
