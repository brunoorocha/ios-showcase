//
//  TVShow.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 30/07/22.
//

import Foundation

struct TVShow: Decodable {
    let title: String
    let image: TVShowCover
    let genres: [String]
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case image
        case genres
    }
}

struct TVShowCover: Decodable {
    let medium: String
    let original: String
}
