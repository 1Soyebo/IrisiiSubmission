//
//  SenderPersisted+CoreDataProperties.swift
//  
//
//  Created by Ibukunoluwa Soyebo on 13/02/2022.
//
//

import Foundation
import CoreData


extension SenderPersisted {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SenderPersisted> {
        return NSFetchRequest<SenderPersisted>(entityName: "SenderPersisted")
    }

    @NSManaged public var phone: String?
    @NSManaged public var name: String?
    @NSManaged public var email: String?

}
