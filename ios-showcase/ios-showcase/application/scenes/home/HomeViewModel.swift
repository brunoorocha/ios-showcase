//
//  HomeViewModel.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import Foundation
import UIKit

protocol HomeViewModelInput: AnyObject {
    func listTVShows()
}

protocol HomeViewModelOutput: AnyObject {
    func presentShows(_ tvShows: [TVShow])
    func presentLoading(_ isLoading: Bool)
    func presentAlert(_ alert: AlertViewModel)
}

struct AlertViewModel {
    let title: String
    let message: String
    let button: String
}

final class HomeViewModel: HomeViewModelInput {
    private let repository: FeaturedTVShowsRepository
    weak var output: HomeViewModelOutput?

    init(repository: FeaturedTVShowsRepository) {
        self.repository = repository
    }

    func listTVShows() {
        output?.presentLoading(true)
        repository.list { [weak self] result in
            switch result {
            case .success(let tvShows):
                self?.output?.presentShows(tvShows)
            case .failure:
                self?.output?.presentAlert(.init(title: "Woops!", message: "We're having some trouble, try again later", button: "Ok"))
            }
            self?.output?.presentLoading(false)
        }
    }
}
