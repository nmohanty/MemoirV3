//
//  ComposeViewController.swift
//  Memoir
//
//  Created by Namrata Mohanty on 12/1/16.
//  Copyright © 2016 Memoir All rights reserved.
//

import UIKit

struct Note {
    var date = Date()
    var text = String()
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    // Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    // Variables
    var fadeTransition: FadeTransition!

    
    //Entry Count
    var entryCount = 0
    
    var textEntered: String!
    var currentCharacterCount: Int!
    var originalPostCount: Int!
    var newPostCount: Int!
    
    var notes: [Note] = [Note]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        textView.becomeFirstResponder()
        textView.text = ""
        originalPostCount = 0
    
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textEntered = textView.text
        var currentNote = Note()
        currentNote.date = Date()
        currentNote.text = textView.text
        
        notes.append(currentNote)
        
        // let dateData = array["date"]
        // let textData = array["text"]
        
        newPostCount = originalPostCount + 1
        var count = 0
        for c in textEntered.characters {
            if String(c) == " " {
                count += 1
            }
        }
        print("The number of words in my string is \(count + 1)")
        
        currentCharacterCount = count + 1
        
        print(notes)
    }
    
    
    /* func textStore() {
     
     //writing to userdefaults
     let defaults = UserDefaults.standard
     defaults.set(entry, forKey: "SavedEntries")*/
    
    
    //reading from userdefaults
    // let array = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()
    //let allEntries = defaults.object(forKey: "SavedEntries") as? [String: String] ?? [String: String]()
    
    @IBAction func didTapSave(_ sender: UIButton) {
        textView.resignFirstResponder()
        performSegue(withIdentifier: "LastEntrySegue", sender: nil)
    }
    
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
        // Access the ComposeViewController that you will be transitioning too, a.k.a, the destinationViewController.
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
        savedentriesViewController.newPostCount = newPostCount
        savedentriesViewController.currentCharacterCount = currentCharacterCount
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
