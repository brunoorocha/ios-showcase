//
//  URLSessionNetworking.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import Foundation

final class URLSessionNetworking: Networking {
    var session: URLSessionable

    init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    @discardableResult
    func request(_ request: URLRequest, completion: @escaping (Result<Data?, NetworkingError>) -> Void) -> DataTask {
        let task = session.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse, (400..<600).contains(response.statusCode) {
                switch response.statusCode {
                case 400: completion(.failure(.badRequest))
                case 401: completion(.failure(.unauthorized))
                case 404: completion(.failure(.notFound))
                case 500: completion(.failure(.server))
                default: completion(.failure(.unknown(response.statusCode)))
                }
                return
            }
            completion(.success(data))
        }
        
        task.resume()
        return task
    }
}

final class GuaranteedOnMainQueueNetworking: Networking {
    private let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }
    
    func request(_ request: URLRequest, completion: @escaping (Result<Data?, NetworkingError>) -> Void) -> DataTask {
        return networking.request(request) { result in
            guard Thread.isMainThread else {
                DispatchQueue.main.async { completion(result) }
                return
            }
            completion(result)
        }
    }
}

extension URLSessionNetworking {
    static var dispatchingOnMainQueue: Networking {
        return GuaranteedOnMainQueueNetworking(networking: URLSessionNetworking())
    }
}
