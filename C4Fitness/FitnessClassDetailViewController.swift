//
//  FitnessClassDetailViewController.swift
//  C4Fitness
//
//  Created by Owner on 11/23/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

class FitnessClassDetailViewController: UITableViewController {

    // class variables
    var fitnessClassModel: FitnessClassModel?
    
    // outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // return to previous controlled when done button pressed
    @IBAction func donePressed(_ sender: Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // remove empty cells at bottom of table
        self.tableView.tableFooterView = UIView()
        
        // setup the menu controller
        self.setRevealViewControllerOptions(menuButton: self.menuButton)
        
        if let fitnessClass = fitnessClassModel {
            nameLabel.text = fitnessClass.name
            durationLabel.text = fitnessClass.duration
            var descriptionString = fitnessClass.descriptionString
            if fitnessClass.footnote != "" {
                descriptionString += "\n\n\n* " + fitnessClass.footnote
            }
            descriptionLabel.text = descriptionString
            descriptionLabel.sizeToFit()
        }
        
        
        // keep the navigation bar from pushing the rest of the window down
        self.navigationController?.navigationBar.isTranslucent = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

