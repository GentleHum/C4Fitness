//
//  TestimonialsViewController.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/16/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

class TestimonialsViewController: UITableViewController {
    // class variables
    var testimonials: [TestimonialModel] = []

    // outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // remove empty cells at bottom of table
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // make the row heights self-sizing
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
        
        // setup the menu controller
        self.setRevealViewControllerOptions(menuButton: self.menuButton)
        
        refreshTestimonials()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTestimonials() {
        ContentServer.downloadTestimonials() { (newTestimonials, serviceError) in
            
            guard serviceError == nil else {
                print(serviceError!.description)
                return
            }
            
            // copy the new scheduled classes to the view controller's storage and sort by sequence number
            self.testimonials = newTestimonials as! [TestimonialModel]
            self.testimonials.sort() { $0.sequenceNumber < $1.sequenceNumber }
            
            // reload screen data
            self.tableView.reloadData()
            
        }
        
    }

}

extension TestimonialsViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestimonialModel")!
        
        let testimonial = testimonials[indexPath.row]
        
        let titleLabel = cell.viewWithTag(2212) as! UILabel!
        titleLabel?.text = testimonial.name + ", " + testimonial.location
        
        let textLabel = cell.viewWithTag(2213) as! UILabel!
        textLabel?.text = testimonial.text
        textLabel?.sizeToFit()
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testimonials.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
