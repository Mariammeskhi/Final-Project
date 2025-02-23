//
//  SongModel.swift
//  Final Project
//
//  Created by mariam meskhi on 19.02.25.
//
import Foundation

struct SongsResponse: Codable {
    let data: [SongDTO]
}

struct SongDTO: Codable {
    let name: String
    let picture: String
}

struct Album: Codable {
    let coverMedium: String?
}
/*"id": 0,
 "name": "All",
 "picture": "https://api.deezer.com/genre/0/image",
 "picture_small": "https://cdn-images.dzcdn.net/images/misc//56x56-000000-80-0-0.jpg",
 "picture_medium": "https://cdn-images.dzcdn.net/images/misc//250x250-000000-80-0-0.jpg",
 "picture_big": "https://cdn-images.dzcdn.net/images/misc//500x500-000000-80-0-0.jpg",
 "picture_xl": "https://cdn-images.dzcdn.net/images/misc//1000x1000-000000-80-0-0.jpg",
 "type": "genre"*/
