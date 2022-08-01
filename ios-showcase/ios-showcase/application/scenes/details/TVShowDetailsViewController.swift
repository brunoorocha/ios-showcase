//
//  TVShowDetailsViewController.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 31/07/22.
//

import UIKit

final class TVShowDetailsViewController: UIViewController {
    private let contentView = TVShowDetailsView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = contentView
    }
}
