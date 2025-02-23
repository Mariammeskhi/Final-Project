//
//  Song+coredata.swift
//  Final Project
//
//  Created by mariam meskhi on 19.02.25.
//
import Foundation
import CoreData

@objc(Song)
public class Song: NSManagedObject {
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var artist: String?
    @NSManaged public var duration: Double
    @NSManaged public var albumCover: String?
    @NSManaged public var users: NSSet?
}

extension Song {
    convenience init(from dto: SongDTO, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = UUID()
        self.name = dto.name
        self.artist = "Unknown Artist"
        self.duration = 0.0
        self.albumCover = dto.picture
    }
}
