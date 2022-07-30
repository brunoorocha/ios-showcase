//
//  LoadingView.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import UIKit

final class LoadingView: UIView {
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        addSubview(label)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),

            label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor)
        ])
    }
    
    func startAnimating() {
        isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        isHidden = true
        activityIndicator.stopAnimating()
    }
}
