//
//  CallManager.swift
//  SaveMe
//
//  Created by Nolan Dey on 2016-01-09.
//  Copyright © 2016 Nolan Dey. All rights reserved.
//

import UIKit

class CallManager: NSObject {
    
    override init() {
        
    }
    
    func call911() {
        let phoneNumber: String = "tel://".stringByAppendingString("289-230-1213")
        UIApplication.sharedApplication().openURL(NSURL(string:phoneNumber)!)
    }

}
