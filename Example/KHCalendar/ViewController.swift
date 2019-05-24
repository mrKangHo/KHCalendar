//
//  ViewController.swift
//  KHCalendar
//
//  Created by 이강호 on 05/24/2019.
//  Copyright (c) 2019 이강호. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      

      KHCalendar.sharedInstance.days()
      /*
       Current Month Days
       
       KHDate Class
       
       */
      
 
      
      
      
      
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func nextPress(){
    
    KHCalendar.sharedInstance.forwardMonth {
      
    }
  }
  
  @IBAction func presentPress(){
    KHCalendar.sharedInstance.presentMonth {
      
      
    }
  }

}

