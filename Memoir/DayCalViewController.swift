//
//  DayCalViewController.swift
//  NSuserdefaultDemo
//
//  Created by Namrata Mohanty on 12/5/16.
//  Copyright © 2016 Memoir All rights reserved.
//

import UIKit
import Foundation

struct TableItem {
    let month: String
    let weekDay: String
    let weekDate: String
    //    let weekDay: String
    //    let weekDate: String
}


class DayCalViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // AFDateHelper
    let now = Date()
    var date = Date()
    
    var sections:[String] = []
    var items:[[TableItem]] = []
    var sectionItems = [TableItem]()
    
    var fadeTransition: FadeTransition!
    
    @IBOutlet weak var postWords: UILabel!
    @IBOutlet weak var bubbleImage: UIImageView!
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var calendarControl: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //var bubbleTransition: BubbleTransition!
    
    var imageView: UIImageView!
    var viewOriginalCenter: CGPoint!
    var bubbleOriginalCenter: CGPoint!
    
    // Variables
    //var entries: [Entry] = []
    
    var lastWordCount: Int!
    var lastPostCount: Int!
    var originFrame: CGRect!
    
    
    var notes: [Note] = [Note]()
    
    var appendedNotes: [Note] = [Note]()
    
    func tap(sender: UITapGestureRecognizer){
        
        if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)) {
            let cell = self.collectionView?.cellForItem(at: indexPath)
            print("you can do something with the cell or index path here")
            //blackBox.alpha = 0
            self.bubbleImage.alpha = 1
            self.postWords.alpha = 1
            UIView.animate(withDuration:
                3, delay:
                0.3, usingSpringWithDamping:
                0.5, initialSpringVelocity:
                1, options: [], animations: {
                    
                    //self.blackBox.isHidden = false
                    // A percentage of the original size. Adjust to taste.
                    let transformScaleTargetValue = CGFloat(10)
                    // Move to the right. Adjust to taste.
                    let transformXTranslationTargetValue = CGFloat(-180.0)
                    // Move down. Adjust to taste.
                    let transformYTranslationTargetValue = CGFloat(-101.0)
                    var transform = CGAffineTransform.identity
                    transform = transform.translatedBy(x: transformXTranslationTargetValue, y: transformYTranslationTargetValue)
                    transform = transform.scaledBy(x:transformScaleTargetValue, y:transformScaleTargetValue)
                    self.bubbleImage.transform = transform
                    self.postWords.transform = transform
                    
                    
                    self.containerView.alpha = 0
                    self.performSegue(withIdentifier: "DaysToTodaySegue", sender: nil)
            }, completion: nil)
            //performSegue(withIdentifier: "WeekToTodaySegue", sender: nil)
            
        } else {
            print("collection view was tapped")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postWords.text = String(lastWordCount)
        bubbleImage.alpha = 0
        postWords.alpha = 0
        viewOriginalCenter = view.center
        // get target bubble location/column center x,y
        //bubbleOriginalCenter = bubbleImageView.center
        //imageView.center = bubbleOriginalCenter
        
        
        /*let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        
        let dateComponents = NSDateComponents()
        dateComponents.day = 8
        dateComponents.month = 11
        dateComponents.year = 2016*/
        
        
        /*if let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian),
         let date = gregorianCalendar.date(from: dateComponents as DateComponents) {
         let weekday = gregorianCalendar.component(.weekday, from: date)
         let month = gregorianCalendar.component(.month, from: date)
         
         print(weekday)
         print(date)
         print(month)*/
        // 5, which corresponds to Thursday in the Gregorian Calendar
        
        
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
        
        
        //var doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didDoubleTapCollectionView:")
        //doubleTapGesture.numberOfTapsRequired = 2  // add double tap
        
        collectionView.isUserInteractionEnabled = true
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        
        ////// From DateHelper extension
        
        
        // Not sure how Section works for CollectionView ???
        sections.append(now.monthToString()) // DECEMBER
        var sectionItems = [TableItem]()
        
        
        
        
        // Ideally we want to register 1. When the user sign in the first time
        // So that it will start the calendar, until today's date
        
        
        // Today-9
        date = now.dateBySubtractingDays(9)
        sectionItems.append(TableItem(month: date.monthToString(), weekDay: date.shortWeekdayToString(), weekDate: date.toString(.custom("d"))))
        
        // Today-8
        date = now.dateBySubtractingDays(8)
        sectionItems.append(TableItem(month: date.monthToString(), weekDay: date.shortWeekdayToString(), weekDate: date.toString(.custom("d"))))
        
        // Today-7
        date = now.dateBySubtractingDays(7)
        sectionItems.append(TableItem(month: date.monthToString(), weekDay: date.shortWeekdayToString(), weekDate: date.toString(.custom("d"))))
        
        // Today-6
        date = now.dateBySubtractingDays(6)
        sectionItems.append(TableItem(month: date.monthToString(), weekDay: date.shortWeekdayToString(), weekDate: date.toString(.custom("d"))))
        
        // Today-5
        date = now.dateBySubtractingDays(5)
        sectionItems.append(TableItem(month: date.monthToString(), weekDay: date.shortWeekdayToString(), weekDate: date.toString(.custom("d"))))
        
        // Today-4
        date = now.dateBySubtractingDays(4)
        sectionItems.append(TableItem(month: date.monthToString(), weekDay: date.shortWeekdayToString(), weekDate: date.toString(.custom("d"))))
        
        // Today-3
        date = now.dateBySubtractingDays(3)
        sectionItems.append(TableItem(month: date.monthToString(), weekDay: date.shortWeekdayToString(), weekDate: date.toString(.custom("d"))))
        
        // Today-2
        date = now.dateBySubtractingDays(2)
        sectionItems.append(TableItem(month: date.monthToString(), weekDay: date.shortWeekdayToString(), weekDate: date.toString(.custom("d"))))
        
        // Yesterday
        date = now.dateBySubtractingDays(1)
        sectionItems.append(TableItem(month: date.monthToString(), weekDay: date.shortWeekdayToString(), weekDate: date.toString(.custom("d"))))
        
        // Today
        date = now
        sectionItems.append(TableItem(month: date.monthToString(), weekDay: date.shortWeekdayToString(), weekDate: date.toString(.custom("d"))))
        
        
        items.append(sectionItems)
        
        
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
                performSegue(withIdentifier: "DaysToTodaySegue", sender: UISwipeGestureRecognizerDirection.up)
                
            default:
                break
            }
        }
    }
    
    
    @IBAction func didTapTodayButton(_ sender: UIButton) {
        performSegue(withIdentifier: "DaysToTodaySegue", sender: nil)
    }
    
    
    
    @IBAction func didTapCalControls(_ sender: UISegmentedControl) {
        if calendarControl.selectedSegmentIndex == 0 {
            performSegue(withIdentifier: "DaysToWeeksSegue", sender: nil)
           
            
        }
        else if calendarControl.selectedSegmentIndex == 1{
             print("correct View")
        }
        else {
            performSegue(withIdentifier: "DaysToWeeksSegue", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Access the ViewController that you will be transitioning too, a.k.a, the destinationViewController.
        if segue.identifier == "DaysToTodaySegue" {
            
            let savedentriesViewController = segue.destination as! SavedEntriesViewController
            
            // Set the modal presentation style of your destinationViewController to be custom.
            savedentriesViewController.modalPresentationStyle = UIModalPresentationStyle.custom
            
            // Create a new instance of your fadeTransition.
            fadeTransition = FadeTransition()
            
            // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
            savedentriesViewController.transitioningDelegate = fadeTransition
            
            // Adjust the transition duration. (seconds)
            fadeTransition.duration = 3.7
            
            savedentriesViewController.notes = appendedNotes
            savedentriesViewController.notes = notes
            
            savedentriesViewController.todayPostCount = lastPostCount
            
            savedentriesViewController.todayWordCount = lastWordCount
        }
        else if segue.identifier == "DaysToWeeksSegue" {
            let calendarViewController = segue.destination as! CalendarViewController
            
            // Set the modal presentation style of your destinationViewController to be custom.
            calendarViewController.modalPresentationStyle = UIModalPresentationStyle.custom
            
            // Create a new instance of your fadeTransition.
            fadeTransition = FadeTransition()
            
            // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
            calendarViewController.transitioningDelegate = fadeTransition
            
            // Adjust the transition duration. (seconds)
            fadeTransition.duration = 1.0
            
            calendarViewController.appendedNotes = appendedNotes
            calendarViewController.notes = notes
            
            calendarViewController.lastPostCount = lastPostCount
            
            calendarViewController.lastWordCount = lastWordCount
            
        }
        else{
            print("go to DaysToMonthsSegue")
        }
        
    }
    
    
    // From DateHelper file
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return 30
        return items[section].count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        let item = items[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        cell.monthLabel.text = item.month
        cell.dayLabel.text = item.weekDay
        cell.dateLabel.text = item.weekDate
        
        // Print the 2 bubbles
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

