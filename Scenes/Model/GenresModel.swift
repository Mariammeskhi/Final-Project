//
//  GenresMode;.swift
//  Final Project
//
//  Created by mariam meskhi on 19.02.25.
//

import Foundation

struct GenresResponse: Codable {
    let data: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
