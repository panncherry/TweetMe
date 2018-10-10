//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Pann Cherry on 10/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenName: String?
    static var current: User?
    
    init(dictionary: [String : Any]) {
        super.init()
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
    }
}
