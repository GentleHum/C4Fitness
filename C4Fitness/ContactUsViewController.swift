//
//  ContactUsViewController.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/16/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit
import MapKit


class ContactUsViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 2000  // number of meters
    let initialLocation =
        CLLocation(latitude: 44.736452500, longitude: -93.181241500)
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion =
            MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                regionRadius * 2.0,
                                                regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // setup the menu controller
        self.setRevealViewControllerOptions(menuButton: self.menuButton)
        
        // set initial location in Apple Valley
        centerMapOnLocation(location: initialLocation)
        mapView.addAnnotation(initialLocation)

       
    }
    
}

extension CLLocation: MKAnnotation {
    
}
