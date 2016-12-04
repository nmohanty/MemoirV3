//
//  CalendarViewController.swift
//  Memoir
//
//  Created by Namrata Mohanty on 12/1/16.
//
//

import UIKit

class Entry: NSObject {
    var text: String = ""
    var wordCount: Int = 0
    var date: NSDate = NSDate() // Today's date
    // var user: PFUser = PFUser()
}

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var fadeTransition: FadeTransition!
    
    //var bubbleTransition: BubbleTransition!
    
    var imageView: UIImageView!
    var viewOriginalCenter: CGPoint!
    var bubbleOriginalCenter: CGPoint!
    
    var entries: [Entry] = []
    
    var lastWordCount: Int!
    var lastPostCount: Int!
    
    
    var notes: [Note] = [Note]()
    
    var appendedNotes: [Note] = [Note]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOriginalCenter = view.center
        // get target bubble location/column center x,y
        //bubbleOriginalCenter = bubbleImageView.center
        //imageView.center = bubbleOriginalCenter
        
        
        let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        
        let dateComponents = NSDateComponents()
        dateComponents.day = 4
        dateComponents.month = 5
        dateComponents.year = 2006
        
        
        if let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian),
            let date = gregorianCalendar.date(from: dateComponents as DateComponents) {
            let weekday = gregorianCalendar.component(.weekday, from: date)
            let month = gregorianCalendar.component(.month, from: date)
            
            print(weekday)
            print(date)
            print(month)
            // 5, which corresponds to Thursday in the Gregorian Calendar
            
            
        }
        
        //  let unitFlags: NSCalendar.Unit = [.hour, .day, .month, .year]
        // let components = NSCalendar.currentCalendar.components(unitFlags, fromDate: dateValue)
        //print(unitFlag.day)
        
        
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
        
        
        var doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didDoubleTapCollectionView:")
        doubleTapGesture.numberOfTapsRequired = 2  // add double tap
        self.collectionView.addGestureRecognizer(doubleTapGesture)
        //add swipe gesture initialisers
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
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
        self.view.addGestureRecognizer(swipeUp)
        
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
                performSegue(withIdentifier: "WeekToTodaySegue", sender: UISwipeGestureRecognizerDirection.up)
                
            default:
                break
            }
        }
    }
    
    
    @IBAction func didTapTodayButton(_ sender: UIButton) {
        performSegue(withIdentifier: "WeekToTodaySegue", sender: nil)
    }
    
    func didDoubleTapCollectionView(gesture: UITapGestureRecognizer) {
        //var pointInCollectionView: CGPoint = gesture.location(in: self.collectionView)
        performSegue(withIdentifier: "WeekToTodaySegue", sender: nil)
        /* var selectedIndexPath: NSIndexPath = self.collectionView(forItemAtPoint: pointInCollectionView)
         var selectedCell: UICollectionViewCell = self.collectionView.cellForItemAtIndexPath(selectedIndexPath as IndexPath)
         // Rest code*/
    }
    
    @IBAction func onTapButtonTest(_ sender: UIButton) {
        performSegue(withIdentifier: "WeekToTodaySegue", sender: nil)
    }
    @IBAction func onTapBubbleWord(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "WeekToTodaySegue", sender: nil)
    }
    
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
        
        savedentriesViewController.notes = appendedNotes
        savedentriesViewController.notes = notes
        
        savedentriesViewController.todayPostCount = lastPostCount
        
        savedentriesViewController.todayWordCount = lastWordCount
        
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








