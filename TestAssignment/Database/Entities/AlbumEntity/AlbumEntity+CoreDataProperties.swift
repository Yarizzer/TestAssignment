//
//  AlbumEntity+CoreDataProperties.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 17.01.2021.
//
//

import Foundation
import CoreData

extension AlbumEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlbumEntity> {
        return NSFetchRequest<AlbumEntity>(entityName: "AlbumEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var userID: Int16
    @NSManaged public var itemEntityRelation: NSSet?
}

// MARK: Generated accessors for itemEntity
extension AlbumEntity {
    @objc(addItemEntityObject:)
    @NSManaged public func addToItemEntity(_ value: ItemEntity)

    @objc(removeItemEntityObject:)
    @NSManaged public func removeFromItemEntity(_ value: ItemEntity)

    @objc(addItemEntity:)
    @NSManaged public func addToItemEntity(_ values: NSSet)

    @objc(removeItemEntity:)
    @NSManaged public func removeFromItemEntity(_ values: NSSet)
}

extension AlbumEntity : Identifiable {

}
