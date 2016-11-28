//
//  TrainerModel.swift
//  C4Fitness
//
//  Created by Owner on 11/17/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

class TrainerModel: NSObject {
    var name: String = ""
    var title: String = ""
    var imageName: String = ""
    var details: String = ""
    var sequenceNumber: Int = 0
    
    init(name: String = "", title: String = "", imageName: String = "", details: String = "", sequenceNumber: Int = 0) {
        self.name = name
        self.title = title
        self.details = details
        self.imageName = imageName
        self.sequenceNumber = sequenceNumber
    }
}

extension TrainerModel: DownloadableDataModel {
    func set(jsonData: Dictionary<String, AnyObject>) {
        if let itemFields: AnyObject = jsonData["fields"] {
            self.name = (itemFields["name"] as? String) ?? ""
            self.title = (itemFields["title"] as? String) ?? ""
            self.imageName = (itemFields["imageName"] as? String) ?? ""
            self.details = (itemFields["details"] as? String) ?? ""
            self.sequenceNumber = (itemFields["sequenceNumber"] as? Int) ?? 0
        }
    }
    
}
