//
//  MenuController.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/16/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit
import SafariServices


class MenuController: UITableViewController {
    // button ID's
    let aboutUsID = "aboutUsButton"
    let scheduleButtonID = "scheduleButton"
    let trainersButtonID = "trainersButton"
    let fitnessClassesButtonID = "fitnessClassesButton"
    let testimonialsButtonID = "testimonialsButton"
    let blogButtonID = "blogButton"
    let contactUsButtonID = "contactUsButton"
    
    // button URL's
    let blogUrl: URL = NSURL(string: "https://www.c-4fitness.com/blog/")! as URL
    

    // return to previous controlled when done button pressed
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.reuseIdentifier == blogButtonID {
                let safariVC = SFSafariViewController(url: blogUrl)
                safariVC.delegate = self
                present(safariVC, animated: true, completion: nil)
            }
        }

        
    }
}

extension MenuController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

