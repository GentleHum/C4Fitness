//
//  FitnessClassModel.swift
//  C4Fitness
//
//  Created by Owner on 11/23/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

class FitnessClassModel: NSObject {
    var name: String = ""
    var descriptionString: String = ""
    var duration: String = ""
    var footnote: String = ""
    var sequenceNumber: Int = 0
    
    init(name: String = "", descriptionString: String = "", duration: String = "", footnote: String = "", sequenceNumber: Int = 0) {
        self.name = name
        self.descriptionString = descriptionString
        self.duration = duration
        self.footnote = footnote
        self.sequenceNumber = sequenceNumber
    }
    

    
}

extension FitnessClassModel: DownloadableDataModel {  
    convenience init(jsonData: JSONDictionary) {
        self.init()
        if let itemFields: AnyObject = jsonData["fields"] {
            self.name = (itemFields["name"] as? String) ?? ""
            self.descriptionString = (itemFields["description"] as? String) ?? ""
            self.duration = (itemFields["duration"] as? String) ?? ""
            self.footnote = (itemFields["footnote"] as? String) ?? ""
            self.sequenceNumber = (itemFields["sequenceNumber"] as? Int) ?? 0
        }
    }
    
    static func createInstance(jsonData: JSONDictionary) -> DownloadableDataModel {
        return FitnessClassModel(jsonData: jsonData)
    }

}

