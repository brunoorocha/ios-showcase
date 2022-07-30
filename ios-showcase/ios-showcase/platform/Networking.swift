//
//  Networking.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import Foundation

enum NetworkingError: Error {
    case badRequest
    case unauthorized
    case notFound
    case server
    case unknown(Int)
}

protocol Networking {
    func request(_ urlRequest: URLRequest, completion: @escaping (Result<Data?, NetworkingError>) -> Void)
}
