//
//  ViewController.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 29/07/22.
//

import UIKit

class ViewController: UIViewController {
    private let repository: FeaturedTVShowsRepository
    
    init(repository: FeaturedTVShowsRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        repository.list { result in
            switch result {
            case .success(let tvShows): print(tvShows)
            case .failure(let error): print(error)
            }
        }
    }
}

