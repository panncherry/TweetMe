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
            retweetCountLabel.text = String(tweet.retweetCount!)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func didTapFavorite(_ sender: Any) {
        if (tweet.favorited == false) {
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                    self.tweet.favoriteCount = tweet.favoriteCount! + 1
                    self.favoriteCountLabel.text = String(format: "%d", tweet.favoriteCount!)
                    self.tweet.favorited = true
                }
            }
        } else {
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
                    self.tweet.favoriteCount = tweet.favoriteCount! - 1
                    self.favoriteCountLabel.text = String(format: "%d", tweet.favoriteCount!)
                    self.tweet.favorited = false
                }
            }
        }
    }

    
    @IBAction func didTapRetweet(_ sender: Any) {
        if (tweet.retweeted == false) {
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
                    self.tweet.retweetCount = tweet.retweetCount! + 1
                    self.retweetCountLabel.text = String(format: "%d", tweet.retweetCount!)
                    self.tweet.retweeted = true
                }
            }
        } else {
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    self.tweet.retweetCount = tweet.retweetCount! - 1
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
                    self.retweetCountLabel.text = String(format: "%d", tweet.retweetCount!)
                    self.tweet.retweeted = false
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
}
