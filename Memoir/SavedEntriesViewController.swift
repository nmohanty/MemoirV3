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
    @IBOutlet weak var postWords: UILabel!
    @IBOutlet weak var postTimes: UILabel!
    
    var fadeTransition: FadeTransition!
    
    var notes: [Note]!
    var currentNote: Note!
    
    
    //var currentCharacterCount: Int!
    var todayWordCount: Int = 0            // cumulative word count
    var todayPostCount: Int = 0           // cumulative post count
    
    
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        notes.append(currentNote)
        //        print(notes)
        
        todayPostCount = notes.count
        todayWordCount = 0
        for aNote in notes {
            todayWordCount += aNote.text.numberOfWords()
        }
        
        // Do any additional setup after loading the view.
        //Set table view to reference needed selves
        self.tableView.reloadData()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        postWords.text = String(todayWordCount)
        
        postTimes.text = String(todayPostCount)
        
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let notes = notes {
            return notes.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell") as! DayTableViewCell
        
        let note = notes[indexPath.row]
        
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
    
    @IBAction func didTapPan(_ sender: UIPanGestureRecognizer) {
        performSegue(withIdentifier: "BackToComposeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Access the ViewController that you will be transitioning too, a.k.a, the destinationViewController.
        let composeViewController = segue.destination as! ComposeViewController
        
        // Set the modal presentation style of your destinationViewController to be custom.
        composeViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        
        // Create a new instance of your fadeTransition.
        fadeTransition = FadeTransition()
        
        // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
        composeViewController.transitioningDelegate = fadeTransition
        
        // Adjust the transition duration. (seconds)
        fadeTransition.duration = 1.0
        
        
        composeViewController.appendedNotes = notes
        composeViewController.notes = notes
        composeViewController.lastPostCount = todayPostCount
        composeViewController.lastWordCount = todayWordCount
        
        
        
        
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
