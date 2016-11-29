//
//  AboutUsViewController.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/16/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    let familyVibeText = "Our gym is located in Apple Valley, MN, near Farmington, Rosemount, and Lakeville. We opened because we saw the positive and transforming power fitness had in our lives and we wanted to pass it on to others. This gym is like an extension of our home. Which means we pay close attention to what our members need and have a personal stake in your success. It’s why so many people enjoy our comfortable and accepting atmosphere."
    
    let noContractsText = "Nope. None. Never ever. You just pay for the classes you take.  Pick individual ones or save even more money with one of our packages. Auto-Pay memberships can be cancelled anytime with no fees. That way you can find a fitness program that fits your schedule and budget without wasting money on equipment or facilities you never use. You’re here to lose weight, not your hard earned cash."
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var familyVibeTextLabel: UILabel!
    @IBOutlet weak var noContractsTextLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        familyVibeTextLabel.text = familyVibeText
        noContractsTextLabel.text = noContractsText
        
        // setup the menu controller
        self.setRevealViewControllerOptions(menuButton: self.menuButton)
        
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}


