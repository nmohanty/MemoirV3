//
//  CalendarViewController.swift
//  Memoir
//
//  Created by Namrata Mohanty on 12/1/16.
//
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var entries: [Entry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        // Parse query and fetch for entries
        // load that into entrie
        
        /*
         // compose view controller
         let newEntry = Entry()
         newEntry.text = "I had a wonderful day!"
         newEntry.wordCount = 5
         newEntry.date = NSDate()
         // newEntry.user = currentUser
         // var newEntryPF = PFObject()
         // newEntryPF["text"] = newEntry.text
         // .saveInBeackgroundWithBlock() {
         // }
         */
        
        // let newEntry = PFObject()
        // newEntry["text"] = some text
        // newEntry["wordCount"] = wordCount
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        cell.dayLabel.text = "Mon"
        cell.dateLabel.text = "7"
        let originalWordCountCenter = cell.wordCountView.center
        var sizeMultiplier = indexPath.item
        if sizeMultiplier > 20 {
            sizeMultiplier = 20
        }
        cell.wordCountView.frame.size = CGSize(width: 1 * sizeMultiplier + 10, height: 1 * sizeMultiplier + 10)
        
        cell.wordCountView.center = originalWordCountCenter
        
        cell.wordCountView.layer.cornerRadius = cell.wordCountView.frame.size.width / 2
        cell.entriesCountView.layer.cornerRadius = cell.entriesCountView.frame.size.width / 2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selcted cell in column \(indexPath.item)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

class Entry: NSObject {
    var text: String = ""
    var wordCount: Int = 0
    var date: NSDate = NSDate() // Today's date
    // var user: PFUser = PFUser()
}






