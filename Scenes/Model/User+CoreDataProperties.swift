//
//  User+CoreDataProperties.swift
//  Final Project
//
//  Created by mariam meskhi on 16.02.25.
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var password: String?
    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var favorites: NSSet?
    
}

// MARK: - Generated accessors for favorites
extension User {
    
    @objc(addFavoritesObject:)
    @NSManaged public func addToFavorites(_ value: Song)

    @objc(removeFavoritesObject:)
    @NSManaged public func removeFromFavorites(_ value: Song)

    @objc(addFavorites:)
    @NSManaged public func addToFavorites(_ values: NSSet)

    @objc(removeFavorites:)
    @NSManaged public func removeFromFavorites(_ values: NSSet)
}

extension User : Identifiable { }

