//
//  RoutePersisted+CoreDataClass.swift
//  
//
//  Created by Ibukunoluwa Soyebo on 13/02/2022.
//
//

import Foundation
import CoreData

@objc(RoutePersisted)
public class RoutePersisted: NSManagedObject, Codable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(start ?? "" , forKey: .start)
        } catch {
            print("error")
        }
    }
        
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "RoutePersisted", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            start = try values.decode(String.self, forKey: .start)
            end = try values.decode(String.self, forKey: .end)
        } catch {
            print ("error")
        }
    }
        
    enum CodingKeys: String, CodingKey {
        case start = "start"
        case end = "end"
    }
}
