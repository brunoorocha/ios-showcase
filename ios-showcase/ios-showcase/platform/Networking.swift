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
    @discardableResult
    func request(_ request: URLRequest, completion: @escaping (Result<Data?, NetworkingError>) -> Void) -> DataTask
}

protocol URLSessionable {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTask
}

extension URLSession: URLSessionable {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTask {
        return (dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask)
    }
}

extension URLRequest {
    static func get(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
