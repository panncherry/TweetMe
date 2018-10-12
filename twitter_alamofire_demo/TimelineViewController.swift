//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Pann Cherry on 2018-10-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet] = []
    
    var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)),
                          for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        fetchTweets()
        logOutAlert()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func fetchTweets() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error loading timeline tweets");
            }
        }
    }
    
    @objc func  pullToRefresh(_ refresh: UIRefreshControl) {
        fetchTweets()
        tableView.reloadData()
        refresh.endRefreshing()
    }
    
    @IBAction func on_logOut(_ sender: Any) {
        present(alertController, animated: true)
    }
    
    func logOutAlert() {
        alertController = UIAlertController(title: "", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        
        let logoutButton = UIAlertAction(title: "Logout", style: .destructive) { (action) in
            self.view.window!.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
            APIManager.shared.logout()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addAction(logoutButton)
        alertController.addAction(cancelButton)
    }
    
}
