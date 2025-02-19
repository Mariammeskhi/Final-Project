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

    @NSManaged public var name: String?
    @NSManaged public var userName: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
}

extension User : Identifiable {

}
