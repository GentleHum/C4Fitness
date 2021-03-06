//
//  DownloadableDataModel.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/22/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit

protocol DownloadableDataModel {
    static func createInstance(jsonData: JSONDictionary) -> DownloadableDataModel
}
