//
//  ContactUsViewController.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/16/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // setup the menu controller
        self.setRevealViewControllerOptions(menuButton: self.menuButton)
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
