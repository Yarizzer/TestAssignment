//
//  ItemEntity+CoreDataProperties.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 17.01.2021.
//
//

import Foundation
import CoreData


extension ItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }

    @NSManaged public var albumID: Int16
    @NSManaged public var id: Int16
    @NSManaged public var thumbnailURL: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var albumEntityRelation: AlbumEntity?

}

extension ItemEntity : Identifiable {

}
