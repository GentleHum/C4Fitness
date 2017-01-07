//
//  ScheduledClassModel.swift
//  C4Fitness
//
//  Created by Owner on 11/17/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

let numberOfSecondsInDay = TimeInterval(24 * 60 * 60)
let numberOfSecondsIn12Hours = TimeInterval(12 * 60 * 60)


class ScheduledClassModel: NSObject {
    var sequenceNumber: Int = 0
    var name: String = ""
    var date: String = ""
    var startTime: String = ""
    var endTime: String = ""
    var trainerName: String = ""
    
    
    init(name: String = "", date: String = "",
         startTime: String = "", endTime: String = "",
         trainerName: String = "", sequenceNumber: Int = 0) {
        self.name = name
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.trainerName = trainerName
        self.sequenceNumber = sequenceNumber
    }
    
    
    func getDateTime() -> Date {
        
        // break the start time into component pieces (e.g. "5:00", "PM")
        let startTimeArray = startTime.characters.split{ $0 == " " }.map(String.init)
        
        // convert string to date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy h:mm"
        var returnDate = dateFormatter.date(from: date + " " + startTimeArray[0])! as Date
        
        // adjust time for PM if necessary (i.e. add 12 hours since AM is default)
        if startTimeArray.count > 1 {
            let meridianString = startTimeArray[1].uppercased()
            if meridianString == "PM" {
                returnDate.addTimeInterval(numberOfSecondsIn12Hours) // add 12 hours for PM (vs AM)
            }
        }
        
        return returnDate
    }
    
}

extension ScheduledClassModel: DownloadableDataModel {
    convenience init(jsonData: JSONDictionary) {
        self.init()
        if let itemFields: AnyObject = jsonData["fields"] {
            self.name = (itemFields["name"] as? String) ?? ""
            self.date = (itemFields["date"] as? String) ?? ""
            self.startTime = (itemFields["startTime"] as? String) ?? ""
            self.endTime = (itemFields["endTime"] as? String) ?? ""
            self.trainerName = (itemFields["trainerName"] as? String) ?? ""
            self.sequenceNumber = (itemFields["sequenceNumber"] as? Int) ?? 0
        }
    }
    
    static func createInstance(jsonData: JSONDictionary) -> DownloadableDataModel {
        return ScheduledClassModel(jsonData: jsonData)
    }

}
