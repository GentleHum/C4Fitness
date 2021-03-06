//
//  TrainersViewController.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/16/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit


class TrainersViewController: UITableViewController {
    // class variables
    var trainers: [TrainerModel] = []

    // outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // remove empty cells at bottom of table
        self.tableView.tableFooterView = UIView()
        
        // make the row heights self-sizing
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        

        // setup the menu controller
        self.setRevealViewControllerOptions(self.menuButton)
        
        self.trainers = ContentModel.trainers
        self.trainers.sort() { $0.sequenceNumber < $1.sequenceNumber }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! TrainerDetailViewController
        if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
            controller.trainerModel = trainers[indexPath.row]
        }
    }
    
}

extension TrainersViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainerModel")!
        
        let trainer = trainers[indexPath.row]
        
        let titleLabel = cell.viewWithTag(2112) as! UILabel!
        titleLabel?.text = trainer.title
        titleLabel?.sizeToFit()
        
        let nameLabel = cell.viewWithTag(2113) as! UILabel!
        nameLabel?.text = trainer.name.uppercased()
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainers.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)        
    }
    
}

