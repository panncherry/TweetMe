//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Pann Cherry on 10/29/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var tweets: Tweet?
    
    @IBOutlet weak var ProfilelPic: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var atUserLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            if let tweet = tweets {
                self.tweets = tweet
            }
        }
}
