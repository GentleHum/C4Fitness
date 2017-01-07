//
//  ClassScheduleViewController.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/16/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit
import CoreData


class ClassScheduleViewController: UITableViewController {
    // class variables
    var scheduledClasses: [ScheduledClassModel] = []
    var datesToShow: [String] = []
    var classDictionary = Dictionary<String, [ScheduledClassModel]>()
    
    
    // outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        setDatesToShow(startDate: "11/20/2016", numberOfDatesToShow: 7) // show a week at a time
        
        // remove empty cells at bottom of table
        self.tableView.tableFooterView = UIView()
        
        // setup the menu controller
        self.setRevealViewControllerOptions(self.menuButton)
        
        // setup the "pull to refresh" option
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(ClassScheduleViewController.handleTableRefresh(_:)), for: UIControlEvents.valueChanged)

        
        // read from the content system
        if ContentModel.scheduledClassesLoaded {
            loadFromContentModel()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
                if ContentModel.scheduledClassesLoaded {
                    self.loadFromContentModel()
                } else {
                    self.showErrorMessage("Encountered an error while loading scheduled classes. Trying swiping down to refresh.")
                }
            })
        }
        
    }
    
    func loadFromContentModel() {
        self.scheduledClasses = ContentModel.scheduledClasses
        self.scheduledClasses.sort() { $0.getDateTime() < $1.getDateTime() }
        
        // update the classes for efficient display
        self.updateClassDictionary()
        
        self.tableView.reloadData()
    }

    
    func getClassesForDate(date: String) -> [ScheduledClassModel]  {
        var classesForDate: [ScheduledClassModel] = []
        
        for currClass in scheduledClasses {
            if currClass.date == date {
                classesForDate.append(currClass)
            }
        }
        
        return classesForDate
    }
    
    func setDatesToShow(startDate: String, numberOfDatesToShow: Int) {
        let dateFormatter = DateFormatter()
        
        datesToShow.removeAll()
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        var currDate = dateFormatter.date(from: startDate)! as Date
        for _ in 0..<numberOfDatesToShow {
            let currDateString = dateFormatter.string(from: currDate)
            datesToShow.append(currDateString)
            currDate.addTimeInterval(numberOfSecondsInDay)
        }
    }
    
    func updateClassDictionary() {
        classDictionary.removeAll()
        for currDateString in datesToShow {
            classDictionary[currDateString] = getClassesForDate(date: currDateString)
        }
    }
    
    func refreshScheduledClasses() {
        ContentModel.loadScheduledClasses() { (serviceError) in
            guard serviceError == nil else {
                print(serviceError!.description)
                self.showErrorMessage(serviceError!.description)
                return
            }
            
            // grab the data from the content model
            self.loadFromContentModel()
        }
    }
    
}

// MARK: support pull to refresh
extension ClassScheduleViewController {
    func handleTableRefresh(_ refreshControl: UIRefreshControl) {
        refreshScheduledClasses()
        refreshControl.endRefreshing()
        
    }
    
    func showErrorMessage(_ errorMessage: String) {
        let alertController = UIAlertController(title: "Service Error", message: errorMessage, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
        }
    }
    
}


// MARK: table view delegate and data source functions
extension ClassScheduleViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduledClassModel")!
        
        let dateToShow = datesToShow[indexPath.section]
        let classesForDate = classDictionary[dateToShow]
        let scheduledClass = classesForDate?[indexPath.row]
        
        let trainerLabel = cell.viewWithTag(2312) as! UILabel!
        trainerLabel?.text = scheduledClass?.trainerName
        
        let nameLabel = cell.viewWithTag(2313) as! UILabel!
        nameLabel?.text = scheduledClass?.name
        
        let durationLabel = cell.viewWithTag(2314) as! UILabel!
        durationLabel?.text = (scheduledClass?.startTime)! + " - " + (scheduledClass?.endTime)!
                
        return cell
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return datesToShow.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRowsInSection = 0
        let dateToShow = self.datesToShow[section]
        if let classesForDate = classDictionary[dateToShow] {
            numRowsInSection = classesForDate.count
        }
        return numRowsInSection
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateFormatter = DateFormatter()
        
        // convert string to date
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: datesToShow[section])! as Date
        
        // convert date back to display string and return
        dateFormatter.dateFormat = "E MMMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28.0
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    

}




