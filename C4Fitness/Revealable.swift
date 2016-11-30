//
//  Revealable.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/19/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

extension UIViewController {
    func setRevealViewControllerOptions(menuButton: UIBarButtonItem?) {
        if let revealViewController = self.revealViewController()  {
            self.view.addGestureRecognizer(revealViewController.panGestureRecognizer())
            revealViewController.presentFrontViewHierarchically = false
            revealViewController.toggleAnimationDuration = 0.3
            revealViewController.bounceBackOnOverdraw = false
            revealViewController.bounceBackOnLeftOverdraw = false
            revealViewController.replaceViewAnimationDuration = 0
            if let button = menuButton {
                button.target = revealViewController
                button.action = #selector(SWRevealViewController.revealToggle(_:))
            }
            
        }
    }
}

