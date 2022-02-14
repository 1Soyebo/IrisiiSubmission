//
//  DeliveryPersisted+CoreDataProperties.swift
//  
//
//  Created by Ibukunoluwa Soyebo on 13/02/2022.
//
//

import Foundation
import CoreData


extension DeliveryPersisted {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeliveryPersisted> {
        return NSFetchRequest<DeliveryPersisted>(entityName: "DeliveryPersisted")
    }

    @NSManaged public var id: String?
    @NSManaged public var remarks: String?
    @NSManaged public var pickupTime: String?
    @NSManaged public var goodsPicture: String?
    @NSManaged public var deliveryFee: String?
    @NSManaged public var surcharge: String?
    @NSManaged public var isfavourite: Bool
    @NSManaged public var date: Date?
    @NSManaged public var route: RoutePersisted?
    @NSManaged public var sender: SenderPersisted?

}
