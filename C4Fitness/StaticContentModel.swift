//
//  StaticContentModel.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/29/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

class StaticContentModel: NSObject {
    var label: String = ""
    var text: String = ""
    
    init(label: String = "", text: String = "") {
        self.label = label
        self.text = text
    }
}

extension StaticContentModel: DownloadableDataModel {
    func set(jsonData: Dictionary<String, AnyObject>) {
        if let itemFields: AnyObject = jsonData["fields"] {
            self.label = (itemFields["label"] as? String) ?? ""
            self.text = (itemFields["text"] as? String) ?? ""
        }
    }
    
}
