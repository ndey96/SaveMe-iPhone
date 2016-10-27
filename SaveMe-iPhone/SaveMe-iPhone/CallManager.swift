//
//  CallManager.swift
//  SaveMe
//
//  Created by Nolan Dey on 2016-01-09.
//  Copyright © 2016 Nolan Dey. All rights reserved.
//

import UIKit
import Alamofire

class CallManager: NSObject {
    
    func call911() {
        let params = ["user_id" : "569c1703eee9ab0300d7dbcc", "location" : "2543356"]
        let headers = ["Host" : "savemeapi.herokuapp.com"]
        Alamofire.request("http://www.savemeapi.herokuapp.com/api/emergencies", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response.request?.allHTTPHeaderFields)  // original URL request
            print(response.response) // URL response
            ////            print(response.data)     // server data
            //            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
        let phoneNumber: String = "tel://" + "289-230-1213"
        UIApplication.shared.openURL(URL(string:phoneNumber)!)
    }
    
}
