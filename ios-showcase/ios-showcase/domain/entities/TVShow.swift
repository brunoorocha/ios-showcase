//
//  TVShow.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import Foundation

struct TVShow: Decodable {
    let title: String
    let genres: [String]
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case genres
    }
}
