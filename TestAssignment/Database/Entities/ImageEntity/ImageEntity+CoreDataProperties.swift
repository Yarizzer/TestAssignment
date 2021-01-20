//
//  ImageEntity+CoreDataProperties.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 17.01.2021.
//
//

import Foundation
import CoreData

extension ImageEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var url: String?
}

extension ImageEntity : Identifiable {

}
