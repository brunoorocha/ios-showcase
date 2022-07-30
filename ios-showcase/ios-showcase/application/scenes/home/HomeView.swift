//
//  HomeView.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import UIKit

final class HomeView: UIView {
    private var loadingView = LoadingView()
    
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
        addSubview(loadingView)
        backgroundColor = .systemBackground
    }

    private func setupConstraints() {
        loadingView.fillSuperview()
    }
}
