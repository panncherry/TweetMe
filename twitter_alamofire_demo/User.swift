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
    var profileImgUrl: String?
    var headerUrl: String?
    var descriptions: String?
    var following: Int?
    var followers: Int?
    var tweetCount: Int?
    var favoriteCount: Int?
 
    private static var _current: User?
    
    // For user persistance
    var dictionary: [String: Any]?
    
    init(dictionary: [String : Any]) {
        super.init()
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImgUrl = dictionary["profile_image_url_https"] as? String
        headerUrl = dictionary["profile_banner_url"] as? String
        descriptions = dictionary["description"] as? String
        following = dictionary["friends_count"] as? Int
        followers = dictionary["followers_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
        favoriteCount = dictionary["favourites_count"] as? Int
    }
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
