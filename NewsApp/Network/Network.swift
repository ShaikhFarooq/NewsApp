//
//  Network.swift
//  NewsApp
//
//  Created by Admin on 9/11/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation
import Alamofire

class Network{
    
    // MARK: - Singleton
    static let shared = Network()
    
    //To make it singleton instance
    private init(){}
    
    // MARK: - Network/API Request
        func fetchNewsHeadlines<T: Codable>(urlByName: String,type: T.Type, completionHandler: ((_ response: T?,_ Success: String,Error?) -> Void)?) {
    
            //returns a list of NewsHeadlines 
            Alamofire.request(urlByName).responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    let newsJSON = value as! NSDictionary
                    let status = newsJSON.value(forKey: "status")! as! NSString
                    print(newsJSON as NSDictionary)
                    print(status)
                    if status == "ok"{
                        do{
                            let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let data = reqJSONStr?.data(using: .utf8)
                            let response = ResponseDecode(data: data!)
                        guard let decoded = response.decode(type) else {
                            return
                        }
                        completionHandler?(decoded,"True", nil)
                    }catch{
                        print(error)
                    }
                }else{
                    completionHandler?(nil,"False",NSError(domain: "No News", code: -101, userInfo: nil))
                }

            case .failure(let err):
                completionHandler?(nil,"False",err)
            }
        }
    }
}

