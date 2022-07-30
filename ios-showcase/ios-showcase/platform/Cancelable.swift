//
//  Cancelable.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import Foundation

protocol Cancelable {
    func cancel()
}

protocol Resumable {
    func resume()
}

typealias DataTask = Cancelable & Resumable

extension URLSessionDataTask: DataTask {}

