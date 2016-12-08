//
//  WelcomeViewController.swift
//  Memoir
//
//  Created by Namrata Mohanty on 11/30/16.
//  Copyright © 2016 Memoir All rights reserved.
//

import UIKit
import Parse
import EventKit

class WelcomeViewController: UIViewController {
    
    // Calendar connect
    /// This is the main Event Kit object that manages event stuff including calendars and reminders
    let eventStore = EKEventStore()
    
    /// An array of calendars
    var calendars: [EKCalendar]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //code
    

        // Do any additional setup after loading the view.
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
                 performSegue(withIdentifier: "ToComposeSegue", sender: UISwipeGestureRecognizerDirection.left)
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
                
            default:
                break
            }
        }
    }


    
    // Calendar connect
    
    override func viewWillAppear(_ animated: Bool) {
        // Check for calendar authorization
        checkCalendarAuthorizationStatus()
        
    }
    
    /// Check to see if user has granted permission access to calendars
    func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: .event)
        
        switch status {
        case .authorized:
            print("We have authorization to access calendar")
        case .notDetermined:
            print("Unknown authorization state, need to check")
            requestCalendarAccess()
        case .restricted, .denied:
            print("Ask user for calendar permission")
        }
    }
    
    func requestCalendarAccess() {
        eventStore.requestAccess(to: .event) { (success: Bool, error: Error?) in
            if success {
                print("Calendar access granted")
                //self.calendars = self.eventStore.calendars(for: .event)
                
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
                
                /// Present alert to go to settings on the main thread
                DispatchQueue.main.async {
                    self.presentCalendarAccessSettingsAlert()
                }
            }
        }
    }
    
    func loadCalendars() {
        
    }
    
    func presentCalendarAccessSettingsAlert() {
        let alertController = UIAlertController(title: "We need calendar access", message: "In order to post your diary entries to add 📔 entries your calendar, we need you to enable 📆 access in settings...please 🙏", preferredStyle: .alert)
        let settingsAlertAction = UIAlertAction(title: "Settings", style: .default, handler: { (UIAlertAction) in
            print("take user to settings")
            if let openSettingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(openSettingsURL, options: [:], completionHandler: nil)
            } else {
                print("open settings url is nil")
            }
        })
        let noThannksAlertAction = UIAlertAction(title: "No Thanks", style: .cancel, handler: nil)
        alertController.addAction(settingsAlertAction)
        alertController.addAction(noThannksAlertAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
}


