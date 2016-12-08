//
//  DetailViewController.swift
//  NSuserdefaultDemo
//
//  Created by Namrata Mohanty on 12/7/16.
//  Copyright © 2016 MOS360. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var scrollViewContentOffsetMaxX: CGFloat!
    var numberOfEntryScreens: Int!
    var notes: [Note]!
    
    // var contentOffset: CGFloat!
    //var offsetValue: CGPoint!
    var index: Int!
    var fadeTransition: FadeTransition!
    
    
    
    var lastWordCount: Int = 0            // cumulative word count
    var lastPostCount: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        numberOfEntryScreens = lastPostCount
        let contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(numberOfEntryScreens), height: scrollView.frame.size.height)
        
        scrollView.contentSize = contentSize
        scrollViewContentOffsetMaxX = scrollView.contentSize.width - scrollView.frame.size.width
        //scrollView.backgroundColor = UIColor(hue: 0, saturation: 1, brightness: 1, alpha: 1)
        scrollView.backgroundColor = UIColor.darkGray
        
        // Setup Labels
        for screenNumber in 0..<numberOfEntryScreens {
            let textlabel = UILabel()
            let dateLabel = UILabel()
            
            //label.text = String(screenNumber + 1)
            let note = notes[screenNumber]
            
            textlabel.text = note.text
            dateLabel.text = note.date.toString()
            
            textlabel.textColor = UIColor.white
            dateLabel.textColor = UIColor.white
            
            textlabel.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightThin)
            dateLabel.font = UIFont.systemFont(ofSize: 36, weight: UIFontWeightThin)
            
            textlabel.sizeToFit()
            scrollView.addSubview(textlabel)
            scrollView.addSubview(dateLabel)
            
            let width = scrollView.frame.size.width
            textlabel.center = CGPoint(x: width / 2 + CGFloat(screenNumber) * width, y: scrollView.frame.size.height / 2)
            dateLabel.center = CGPoint(x: width / 2 + CGFloat(screenNumber) * width, y: scrollView.frame.size.height / 20)
            
        }
        
        // Setup Page Control
        pageControl.numberOfPages = numberOfEntryScreens
        
    }
    
    
    
    @IBAction func didTapBackArrowButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "DetailToTodaySegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Access the ViewController that you will be transitioning too, a.k.a, the destinationViewController.
        // pass data to next view
        let todayViewController = segue.destination as! SavedEntriesViewController
        todayViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        fadeTransition = FadeTransition()
        todayViewController.transitioningDelegate = fadeTransition
        fadeTransition.duration = 2.5
        //calendarViewController.appendedNotes = notes
        todayViewController.notes = notes
        todayViewController.todayPostCount = lastPostCount
        todayViewController.todayWordCount = lastWordCount
        
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
