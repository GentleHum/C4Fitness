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
        self.setRevealViewControllerOptions(self.menuButton)
        
        self.testimonials = ContentModel.testimonials
        self.testimonials.sort() { $0.sequenceNumber < $1.sequenceNumber }
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
