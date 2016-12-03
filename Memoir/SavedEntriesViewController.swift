//
//  SavedEntriesViewController.swift
//  Memoir
//
//  Created by Namrata Mohanty on 12/1/16.
//  Copyright © 2016 Memoir All rights reserved.
//

import UIKit
import Parse

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        return dateFormatter.string(from: self)
    }
}

class SavedEntriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes: [Note]!
    
    var currentCharacterCount: Int!
    var newPostCount: Int!
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        //Set table view to reference needed selves
        self.tableView.reloadData()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        // "October 8, 2016"
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        let current_date = formatter.string(from: currentDateTime)
        
        //currentDateTitleLable.text = "\(current_date)"
        // print("\(current_date)")
        
    }
    @IBAction func didPanView(_ sender: UIPanGestureRecognizer) {
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newPostCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell") as! DayTableViewCell
        
        let note = notes[indexPath.section]
        
        //Set time in cell
        
        /*let formatter = DateFormatter()
         // "October 8, 2016"
         formatter.timeStyle = .short
         formatter.dateStyle = .none
         let historic_time = formatter.string(from: date)
         cell.postDateLabel.text = "\(historic_time)"*/
        
        
        cell.postTextLabel.text = note.text
        cell.postDateLabel.text = note.date.toString()
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
