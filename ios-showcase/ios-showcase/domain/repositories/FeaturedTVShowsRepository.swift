//
//  FeaturedTVShowsRepository.swift
//  ios-showcaseTests
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import Foundation

enum FeaturedTVShowsRepositoryError: Error {
    case malformedRequest
    case unableToDecodeResponse(Error)
    case unknown(Error)
}

protocol FeaturedTVShowsRepository {
    @discardableResult
    func list(completion: @escaping (Result<[TVShow], FeaturedTVShowsRepositoryError>) -> Void) -> Cancelable?
}
