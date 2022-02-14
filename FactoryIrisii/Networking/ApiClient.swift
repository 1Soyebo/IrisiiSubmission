//
//  ApiClient.swift
//  FactoryIrisii
//
//  Created by Ibukunoluwa Soyebo on 13/02/2022.
//

import Foundation
import Alamofire

class ApiClient{
    
    let endpointGetDeliveries = "v2/deliveries"
    let baseURL = "https://mock-api-mobile.dev.lalamove.com/"
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let factorIrisiiStateContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static let shared = ApiClient()
    private init(){}
    
    func getDeliveries(offset:Int, limit: Int, assignResultsTo: @escaping (inout [DeliveryPersisted]) -> Void){
        let computedLimit = limit < 1 ? 20:limit
        let queryString = "?offset=\(offset)&limit=\(computedLimit)"
        let completeURL = baseURL + endpointGetDeliveries + queryString
        print(completeURL)
        
        AF.request(completeURL, method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 199..<300)
            .responseJSON{[weak self] response in
                switch response.result{
                case.success:
                    guard let hmm = response.data else {return}
                    let decoder = JSONDecoder()
                    decoder.userInfo[CodingUserInfoKey.context!] = self?.factorIrisiiStateContext

                    if var results = try? decoder.decode([DeliveryPersisted].self, from: hmm) {
                        assignResultsTo(&results)
                    }
                case.failure(let error):
                    var results = [DeliveryPersisted]()
                    assignResultsTo(&results)
                    print(error.localizedDescription)
                }
                
            }
    }
    
    
    func saveContext() {
        if factorIrisiiStateContext.hasChanges {
            do {
                try factorIrisiiStateContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
