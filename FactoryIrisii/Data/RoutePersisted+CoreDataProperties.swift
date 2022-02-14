//
//  RoutePersisted+CoreDataProperties.swift
//  
//
//  Created by Ibukunoluwa Soyebo on 13/02/2022.
//
//

import Foundation
import CoreData


extension RoutePersisted {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoutePersisted> {
        return NSFetchRequest<RoutePersisted>(entityName: "RoutePersisted")
    }

    @NSManaged public var start: String?
    @NSManaged public var end: String?

}
