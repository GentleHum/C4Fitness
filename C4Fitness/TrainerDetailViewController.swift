//
//  TrainerDetailViewController.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/18/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

class TrainerDetailViewController: UITableViewController {

    // class variables
    var trainerModel: TrainerModel?
        
    // outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsView: UILabel!
    @IBOutlet weak var trainerImage: UIImageView!
    
    // return to previous controlled when done button pressed
    @IBAction func donePressed(_ sender: Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // remove empty cells at bottom of table
        self.tableView.tableFooterView = UIView()
        
        // make the cells self-sizing
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200

        
        // setup the menu controller
        self.setRevealViewControllerOptions(menuButton: self.menuButton)
        
        if let trainer = trainerModel {
            nameLabel.text = trainer.name.uppercased()
            titleLabel.text = trainer.title
            detailsView.text = trainer.details
            trainerImage.image = UIImage(named: trainer.imageName)
        }
        
        // title should size to fit regardless of number of lines
        titleLabel.sizeToFit()
        
        // keep the navigation bar from pushing the rest of the window down
        self.navigationController?.navigationBar.isTranslucent = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



