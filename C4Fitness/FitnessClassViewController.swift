//
//  FitnessClassViewController.swift
//  C4Fitness
//
//  Created by Owner on 11/23/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

class FitnessClassViewController: UITableViewController {

    // class variables
    var fitnessClasses: [FitnessClassModel] = []
    
    // outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // remove empty cells at bottom of table
        self.tableView.tableFooterView = UIView()
        
        // setup the menu controller
        self.setRevealViewControllerOptions(menuButton: self.menuButton)
        
        // title should size to fit regardless of number of lines
        
        refreshFitnessClasses()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshFitnessClasses() {
        ContentServer.downloadFitnessClasses() { (newFitnessClasses, serviceError) in
            
            guard serviceError == nil else {
                print(serviceError!.description)
                return
            }
            
            // copy the new scheduled classes to the view controller's storage
            self.fitnessClasses = newFitnessClasses as! [FitnessClassModel]
            self.fitnessClasses.sort() { $0.sequenceNumber < $1.sequenceNumber }
            
            
            // reload screen data
            self.tableView.reloadData()
            
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! FitnessClassDetailViewController
        if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
            controller.fitnessClassModel = fitnessClasses[indexPath.row]
        }
    }

    
}

extension FitnessClassViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessClassModel")!
        
        let fitnessClass = fitnessClasses[indexPath.row]
                
        let nameLabel = cell.viewWithTag(2412) as! UILabel!
        nameLabel?.text = fitnessClass.name
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fitnessClasses.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

