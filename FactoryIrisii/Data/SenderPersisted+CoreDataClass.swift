//
//  SenderPersisted+CoreDataClass.swift
//  
//
//  Created by Ibukunoluwa Soyebo on 13/02/2022.
//
//

import Foundation
import CoreData

@objc(SenderPersisted)
public class SenderPersisted: NSManagedObject, Codable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(name ?? "" , forKey: .name)
        } catch {
            print("error")
        }
    }
        
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "SenderPersisted", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            name = try values.decode(String.self, forKey: .name)
            phone = try values.decode(String.self, forKey: .phone)
            email = try values.decode(String.self, forKey: .email)
        } catch {
            print ("error")
        }
    }
        
    enum CodingKeys: String, CodingKey {
        case phone = "phone"
        case name = "name"
        case email = "email"

    }

}
