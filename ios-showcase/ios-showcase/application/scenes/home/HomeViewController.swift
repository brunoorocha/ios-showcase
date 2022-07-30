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
        viewModel.listTVShows()
    }
}

extension HomeViewController: HomeViewModelOutput {
    func presentShows(_ tvShows: [TVShow]) {
        
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
