//
//  TestimonialModel.swift
//  C4Fitness
//
//  Created by Owner on 11/17/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

class TestimonialModel: NSObject {
    var name: String = ""
    var location: String = ""
    var text: String = ""
    var sequenceNumber: Int = 0
    
    init(name: String = "", location: String = "", text: String = "", sequenceNumber: Int = 0) {
        self.name = name
        self.location = location
        self.text = text
        self.sequenceNumber = sequenceNumber
    }
}

extension TestimonialModel: DownloadableDataModel {
    func set(jsonData: Dictionary<String, AnyObject>) {
        if let itemFields: AnyObject = jsonData["fields"] {
            self.name = (itemFields["name"] as? String) ?? ""
            self.location = (itemFields["location"] as? String) ?? ""
            self.text = (itemFields["text"] as? String) ?? ""
            self.sequenceNumber = (itemFields["sequenceNumber"] as? Int) ?? 0
        }
    }
    
}
