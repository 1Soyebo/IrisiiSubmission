//
//  DeliveryPersisted+CoreDataClass.swift
//  
//
//  Created by Ibukunoluwa Soyebo on 13/02/2022.
//
//

import Foundation
import CoreData

@objc(DeliveryPersisted)
public class DeliveryPersisted: NSManagedObject, Codable{
    
    func getFromTime() -> String{
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let startTime = fromDateFormatter.date(from: pickupTime ?? "") else{
            return ""
        }
        let otherDate = DateFormatter()
        otherDate.dateStyle = .medium
        return otherDate.string(from: startTime)
    }
    
    var startTime: Date{
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let configuredStartTime = fromDateFormatter.date(from: pickupTime ?? "")
            
        return configuredStartTime ?? Date()
    }
    
    func getPictureURL() -> URL?{
        return .init(string: goodsPicture ?? "")
    }
    
    func getAmount() -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        //Amount: to fix
        if let deliveryFeeNumber = formatter.number(from: deliveryFee ?? ""), let surchargeNumber = formatter.number(from: surcharge ?? "") {
            let amount = deliveryFeeNumber.floatValue + surchargeNumber.floatValue
            return "$" + String(format: "%.2f", amount)
        }else{
            return ""
        }
    }


    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(id ?? "blank", forKey: .id)
        } catch {
            print("error")
        }
    }
        
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
        let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
        let entity = NSEntityDescription.entity(forEntityName: "DeliveryPersisted", in: managedObjectContext)
        else {
            fatalError("decode failure")
        }
        
        
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try values.decode(String.self, forKey: .id)
            remarks = try values.decode(String.self, forKey: .remarks)
            pickupTime = try values.decode(String.self, forKey: .pickupTime)
            goodsPicture = try values.decode(String.self, forKey: .goodsPicture)
            deliveryFee = try values.decode(String.self, forKey: .deliveryFee)
            surcharge = try values.decode(String.self, forKey: .surcharge)
            route = try values.decode(RoutePersisted.self, forKey: .route)
            sender = try values.decode(SenderPersisted.self, forKey: .sender)
            date = startTime

        } catch {
            print ("error")
        }
    }
        
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case remarks = "remarks"
        case pickupTime = "pickupTime"
        case goodsPicture = "goodsPicture"
        case deliveryFee = "deliveryFee"
        case surcharge = "surcharge"
        case route = "route"
        case sender = "sender"

    }
}
