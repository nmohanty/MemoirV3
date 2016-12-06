//
//  SavedEntriesViewController.swift
//  NSuserdefaultDemo
//
//  Created by Namrata Mohanty on 11/27/16.
//  Copyright © 2016 MOS360. All rights reserved.
//

import UIKit


/*extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        return dateFormatter.string(from: self)
    }
}*/

class SavedEntriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postWords: UILabel!
    @IBOutlet weak var postTimes: UILabel!
    @IBOutlet weak var wordstxtLabel: UILabel!
    
    var fadeTransition: FadeTransition!
    
    //var bubbleTransition: BubbleTransition!
    
    
    
    @IBOutlet weak var containerView: UIView!
    
    //@IBOutlet weak var blackBox: UIView!
    @IBOutlet weak var bubbleImageView: UIImageView!
    var notes: [Note]!
    var currentNote: Note!
    
    var imageBubble: UIImage!
    var bubbleOriginalCenter: CGPoint!
    var viewOriginalCenter: CGPoint!
    //var countLabel: UILabel!
    
    
    //var currentCharacterCount: Int!
    var todayWordCount: Int = 0            // cumulative word count
    var todayPostCount: Int = 0           // cumulative post count
    
    
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        notes.append(currentNote)
        //        print(notes)
        //blackBox.alpha = 0
        bubbleOriginalCenter = bubbleImageView.center
        
        let imageBubble =  bubbleImageView.image
        postWords.center = bubbleImageView.center
        wordstxtLabel.center.y = bubbleImageView.center.y - 100
        viewOriginalCenter = containerView.center
        
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
        
        //add swipe gesture initialisers
        /*let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target:self, action:#selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)*/
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
                performSegue(withIdentifier: "BackToComposeSegue", sender: UISwipeGestureRecognizerDirection.up)
            default:
                break
            }
        }
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
        let translation = sender.translation(in: view)
        
        //imageView = sender.view as! UIImageView
        // imageView.frame = sender.view!.frame
        
        if sender.state == .began {
            //this is called only once
            //imageView.center = bubbleImageView.icenter
            self.view.center = self.viewOriginalCenter
        }
            
        else if sender.state == .changed {
            
            //called cont as we pan
            //            bubbleImageView.center = CGPoint(x: bubbleOriginalCenter.x, y: bubbleOriginalCenter.y + translation.y)
            postWords.center = bubbleImageView.center
            // A percentage of the original size. Adjust to taste.
            let transformScaleTargetValue = CGFloat(1.0/7.0)
            // Move to the right. Adjust to taste.
            let transformXTranslationTargetValue = CGFloat(63.0)
            // Move down. Adjust to taste.
            let transformYTranslationTargetValue = CGFloat(105.0)
            
            let transformScaleValue = convertValue(inputValue: translation.y, r1Min: 0, r1Max: 100, r2Min: 1.0, r2Max: transformScaleTargetValue)
            let transformXTranslationValue = convertValue(inputValue: translation.y, r1Min: 0, r1Max: 100, r2Min: 0, r2Max: transformXTranslationTargetValue)
            let transformYTranslationValue = convertValue(inputValue: translation.y, r1Min: 0, r1Max: 100, r2Min: 0, r2Max: transformYTranslationTargetValue)
            
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: transformXTranslationValue, y: transformYTranslationValue)
            transform = transform.scaledBy(x:transformScaleValue, y:transformScaleValue)
            bubbleImageView.transform = transform
            postWords.transform = transform
            
            
            
            wordstxtLabel.center.y = bubbleImageView.center.y - 100
            containerView.center = CGPoint(x: self.view.center.x, y: self.view.center.y + translation.y)
            if translation.y > 0 && translation.y < 100 {
                // blackBox.alpha = 0
                containerView.alpha = convertValue(inputValue: translation.y, r1Min: 0, r1Max: 100, r2Min: 1, r2Max: 0.1)
                
            }
            else
            {
                //blackBox.alpha = 0
                containerView.alpha = convertValue(inputValue: translation.y, r1Min: 0, r1Max: -100, r2Min: 1, r2Max: 0.4)
                UIView.animate(withDuration:
                    0.8, delay:
                    0, usingSpringWithDamping:
                    0.5, initialSpringVelocity:
                    1, options: [], animations: {
                        // self.blackBox.isHidden = false
                        self.containerView.alpha = 0
                        
                }, completion: nil)
                self.performSegue(withIdentifier: "ToCalendarSegue", sender: nil)
            }
            
            //print("x: \(location.x), y: \(location.y)")
        }
            
        else if sender.state == .ended {
            //called once
            if translation.y < 100 {
                
                //blackBox.isHidden = true
                
                UIView.animate(withDuration:
                    0.4, delay:
                    0, usingSpringWithDamping:
                    0.5, initialSpringVelocity:
                    1, options: [], animations: {
                        self.containerView.center = self.viewOriginalCenter
                        self.view.center = self.viewOriginalCenter
                        self.bubbleImageView.center = self.bubbleOriginalCenter
                        self.postWords.center = self.bubbleImageView.center
                        self.wordstxtLabel.center.y = self.bubbleImageView.center.y - 100
                        self.containerView.alpha = 1
                        self.postWords.transform = CGAffineTransform.identity
                        self.bubbleImageView.transform = CGAffineTransform.identity
                }, completion: nil)
            }
                
            else
            {
                UIView.animate(withDuration:
                    0.8, delay:
                    0, usingSpringWithDamping:
                    0.5, initialSpringVelocity:
                    1, options: [], animations: {
                        //  self.blackBox.isHidden = false
                        self.containerView.alpha = 0
                        
                }, completion: nil)
                self.performSegue(withIdentifier: "ToCalendarSegue", sender: nil)
            }
            
            //print("x: \(location.x), y: \(location.y)")
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Access the ViewController that you will be transitioning too, a.k.a, the destinationViewController.
        if segue.identifier == "ToCalendarSegue" {
            // pass data to next view
            let calendarViewController = segue.destination as! CalendarViewController
            calendarViewController.modalPresentationStyle = UIModalPresentationStyle.custom
            fadeTransition = FadeTransition()
            calendarViewController.transitioningDelegate = fadeTransition
            fadeTransition.duration = 2.5
            calendarViewController.appendedNotes = notes
            calendarViewController.notes = notes
            calendarViewController.lastPostCount = todayPostCount
            calendarViewController.lastWordCount = todayWordCount
            
        }
        else{
            let composeViewController = segue.destination as! ComposeViewController
            
            // Set the modal presentation style of your destinationViewController to be custom.
            composeViewController.modalPresentationStyle = UIModalPresentationStyle.custom
            
            // Create a new instance of your fadeTransition.
            fadeTransition = FadeTransition()
            
            // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
            composeViewController.transitioningDelegate = fadeTransition
            
            // Adjust the transition duration. (seconds)
            fadeTransition.duration = 0.2
            
            
            composeViewController.appendedNotes = notes
            composeViewController.notes = notes
            composeViewController.lastPostCount = todayPostCount
            composeViewController.lastWordCount = todayWordCount
        }
        
        
        
        
    }
    
    @IBAction func didTapCompose(_ sender: UIButton) {
        self.performSegue(withIdentifier: "BackToComposeSegue", sender: nil)
        
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

