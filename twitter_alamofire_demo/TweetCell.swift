//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Pann Cherry on 10/12/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profilelPic: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var atUserLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var replyCountLabel: TTTAttributedLabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: TTTAttributedLabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: TTTAttributedLabel!
    
    @IBOutlet weak var messageButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var tweet: Tweet! {
        didSet {
            if tweet.user?.profileImgUrl != nil {
                let profileURL = URL(string: (tweet.user?.profileImgUrl!)!)
                profilelPic.af_setImage(withURL: profileURL!)
            }
            tweetLabel.text = tweet.text
            userNameLabel.text = tweet.user!.name
            atUserLabel.text = String(format: "@%@", tweet.user!.screenName!)
            dateLabel.text = tweet.createdAtString
            favoriteCountLabel.text = String(format: "%d", tweet.favoriteCount!)
            //retweetCountLabel.text = String(tweet.retweetCount)
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
