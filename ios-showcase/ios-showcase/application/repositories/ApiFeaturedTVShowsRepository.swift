//
//  ApiFeaturedTVShowsRepository.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import Foundation

final class ApiFeaturedTVShowsRepository: FeaturedTVShowsRepository {
    private let networkingService: Networking

    init(networkingService: Networking) {
        self.networkingService = networkingService
    }

    func list(completion: @escaping (Result<[TVShow], FeaturedTVShowsRepositoryError>) -> Void) {
        let request = URLRequest(url: URL(string: "https://api.tvmaze.com/shows?page=0")!)
        networkingService.request(request) { result in
            switch result {
            case .success(let data):
                do {
                    guard let data = data else {
                        completion(.success([]))
                        return
                    }
                    let decoded = try JSONDecoder().decode([TVShow].self, from: data)
                    completion(.success(decoded))
                }
                catch {
                    completion(.failure(.unableToDecodeResponse(error)))
                }
            case .failure(let error):
                completion(.failure(.unknown(error)))
            }
        }
    }
}
