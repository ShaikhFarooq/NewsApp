//
//  Headlines+CoreDataProperties.swift
//  
//
//  Created by Admin on 9/16/19.
//
//

import Foundation
import CoreData


extension Headlines {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Headlines> {
        return NSFetchRequest<Headlines>(entityName: "Headlines")
    }

    @NSManaged public var date: String?
    @NSManaged public var title: String?
    @NSManaged public var descrip: String?
    @NSManaged public var author: String?
    @NSManaged public var poster: String?

}
