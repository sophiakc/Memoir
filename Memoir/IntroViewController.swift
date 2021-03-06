//
//  IntroViewController.swift
//  Memoir
//
//  Created by Namrata Mohanty on 12/1/16.
//  Copyright © 2016 Memoir All rights reserved.
//

import UIKit
import Parse

class IntroViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 960, height: 568)

        getStartedButton.alpha = 0
        loginButton.alpha = 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // This method is called as the user scrolls
        
        print("scrollingdidhappen")
        let page : Int = Int (round(scrollView.contentOffset.x/320
        ))
        print(page)
        
        // Set the current page, so the dots will update
        self.pageControl.currentPage = page
        if page == 2 {
            self.pageControl.isHidden = true
            //            getStartedButton.alpha = 1
        }
        else {
            getStartedButton.alpha = 0
            loginButton.alpha = 0

            
        }
        
        //Calculate the page we are on based on x coordinate position and width of scroll view
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Get the current page based on the scroll offset
        let page : Int = Int(round(scrollView.contentOffset.x / 320))
        
        // Set the current page, so the dots will update
        self.pageControl.currentPage = page
        
        if page == 2 {
            self.pageControl.isHidden = true
            UIView.animate(withDuration: 0.18, animations: {
                self.loginButton.alpha = 1
                self.getStartedButton.alpha = 1
            })
            
        }
        else {
            self.pageControl.isHidden = false
            
            getStartedButton.alpha = 0
        }
    }

}
