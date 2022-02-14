//
//  Delivery.swift
//  FactoryIrisii
//
//  Created by Ibukunoluwa Soyebo on 13/02/2022.
//

import Foundation

struct Delivery: Codable{
    
    let id: String
    let remarks: String
    private let pickupTime: String
    private let goodsPicture: String
    private let deliveryFee: String
    private let surcharge: String
    let route: DeliveryRoute
    let sender: DeliverySender
    var isfavourite:Bool? = false
    
    func getFromTime() -> String{
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let startTime = fromDateFormatter.date(from: pickupTime) else{
            return ""
        }
        let otherDate = DateFormatter()
        otherDate.dateStyle = .medium
        return otherDate.string(from: startTime)
    }
    
    func getPictureURL() -> URL?{
        return .init(string: goodsPicture)
    }
    
    func getAmount() -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        //Amount: to fix
        if let deliveryFeeNumber = formatter.number(from: deliveryFee), let surchargeNumber = formatter.number(from: surcharge) {
            let amount = deliveryFeeNumber.floatValue + surchargeNumber.floatValue
            return "$" + String(format: "%.2f", amount)
        }else{
            return ""
        }
    }
}

struct DeliveryRoute: Codable{
    let start: String
    let end: String
}

struct DeliverySender: Codable{
    let phone: String
    let name: String
    let email: String
}
