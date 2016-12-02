//
//  TodayViewController.swift
//  Memoir
//
//  Created by Namrata Mohanty on 12/1/16.
//
//

import UIKit
import Parse

class TodayViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var chatField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        fetchMessages()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TodayViewController.didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func didPullToRefresh() {
        fetchMessages()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell") as! DayTableViewCell
        
        let message = messages[indexPath.row]
        if let text = message["text"] as? String {
            cell.textEntry.text = text
        }
        
        return cell
    }
    
    @IBAction func didTapSend(_ sender: Any) {
        let message = PFObject(className: "Message_ios_design")
        message["text"] = chatField.text!
        chatField.text = ""
        message.saveInBackground { (success: Bool, error: Error?) in
            if success {
                print("Saved message")
                self.fetchMessages()
            } else {
                print(error!.localizedDescription)
            }
        }
        
    }
    
    func fetchMessages() {
        
        let query = PFQuery(className: "Message_ios_design")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) in
            // called after trying to fetch messages
            if error == nil {
                print("success")
                if let messages = messages {
                    self.messages = messages
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            } else {
                print(error!.localizedDescription)
                self.refreshControl.endRefreshing()
            }
        }
    }
}
