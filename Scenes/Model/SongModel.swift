//
//  SongModel.swift
//  Final Project
//
//  Created by mariam meskhi on 19.02.25.
//

struct SongsResponse: Codable {
    let data: [Song]
}

struct Song: Codable {
    let title: String
    let album: Album
}

struct Album: Codable {
    let coverMedium: String 
}
