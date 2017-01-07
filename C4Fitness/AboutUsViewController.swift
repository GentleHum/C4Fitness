//
//  AboutUsViewController.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/16/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var familyVibeHeaderLabel: UILabel!
    @IBOutlet weak var familyVibeTextLabel: UILabel!
    @IBOutlet weak var noContractsHeaderLabel: UILabel!
    @IBOutlet weak var noContractsTextLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        familyVibeHeaderLabel.text = ContentModel.familyVibeHeader
        familyVibeTextLabel.text = ContentModel.familyVibeText
        noContractsHeaderLabel.text = ContentModel.noContractsHeader
        noContractsTextLabel.text = ContentModel.noContractsText
        
        // setup the menu controller
        self.setRevealViewControllerOptions(self.menuButton)
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}


