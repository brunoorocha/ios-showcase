//
//  HomeFactory.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import Foundation

enum HomeFactory {
    static func make() -> HomeViewController {
        let networking = URLSessionNetworking.dispatchingOnMainQueue
        let repository = ApiFeaturedTVShowsRepository(networkingService: networking)
        let viewModel = HomeViewModel(repository: repository)
        let controller = HomeViewController(viewModel: viewModel)
        viewModel.output = controller
        return controller
    }
}
