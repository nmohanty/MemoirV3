//
//  ComposeViewController.swift
//  Memoir
//
//  Created by Namrata Mohanty on 12/1/16.
//  Copyright © 2016 Memoir All rights reserved.
//

import UIKit
import Parse

struct Note {
    var date = Date()
    var text = String()
}

extension String {
    func numberOfWords()->Int {
        var addCount = 0
        var lastCharWasNotPartOfAWord = false
        for c in self.characters {
            if String(c) == " " || String(c) == "\n" {
                if (lastCharWasNotPartOfAWord == false) {
                    addCount += 1
                }
                lastCharWasNotPartOfAWord = true
            } else {
                lastCharWasNotPartOfAWord = false
            }
        }
        return addCount + 1
    }
}


class ComposeViewController: UIViewController, UITextViewDelegate {
    
    var fadeTransition: FadeTransition!
    
    @IBOutlet weak var textView: UITextView!
    
    
    //Entry Count
    //var notesAll: [Note]!
    
    @IBOutlet weak var dateLabel: UILabel!
    var textEntered: String!
    var currentWordCount: Int = 0
    var originalPostCount: Int = 1
    var cumulativePostCount: Int!
    
    var lastWordCount: Int!
    var lastPostCount: Int!
    
    
    var notes: [Note] = [Note]()
    
    var appendedNotes: [Note] = [Note]()
    
    var currentNote: Note!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.delegate = self
        textView.becomeFirstResponder()
        textView.text = ""
        dateLabel.text = ""
        
        
    }
    
    
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textEntered = textView.text
        currentNote = Note(date: Date(), text: textView.text)
        
        //currentNote.date = Date()
        //currentNote.text = textView.text
        
        
        // let dateData = array["date"]
        // let textData = array["text"]
        
        
        cumulativePostCount = notes.count + 1
        
        
        //ger current word count for current entry
        let addCount = textEntered.numberOfWords()
        print("The number of words in my string is \(addCount + 1)")
        
        currentWordCount =  addCount + 1
        
        //add past wordc ounts to current
        
        print(notes, "The notes count is \(cumulativePostCount)")
        notes.append(currentNote)
    }
    
    
    
    
    /* func textStore() {
     
     //writing to userdefaults
     let defaults = UserDefaults.standard
     defaults.set(entry, forKey: "SavedEntries")*/
    
    
    //reading from userdefaults
    // let array = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()
    //let allEntries = defaults.object(forKey: "SavedEntries") as? [String: String] ?? [String: String]()
    
    
    @IBAction func onDidPan(_ sender: UIPanGestureRecognizer) {
        textView.resignFirstResponder()
        performSegue(withIdentifier: "LastEntrySegue", sender: nil)
        
    }
    
    /* @IBAction func didPressSaveButton(_ sender: UIButton) {
     //textStore()
     let defaults = UserDefaults.standard
     let myEntry = defaults.object(forKey: "myEnrty") as! [String: Any]
     print(myEntry)
     }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Access the ViewController that you will be transitioning too, a.k.a, the destinationViewController.
        let savedentriesViewController = segue.destination as! SavedEntriesViewController
        
        // Set the modal presentation style of your destinationViewController to be custom.
        savedentriesViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        
        // Create a new instance of your fadeTransition.
        fadeTransition = FadeTransition()
        
        // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
        savedentriesViewController.transitioningDelegate = fadeTransition
        
        // Adjust the transition duration. (seconds)
        fadeTransition.duration = 1.0
        
        savedentriesViewController.notes = notes
        savedentriesViewController.todayPostCount = cumulativePostCount
        savedentriesViewController.todayWordCount = currentWordCount
        savedentriesViewController.currentNote = currentNote
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
