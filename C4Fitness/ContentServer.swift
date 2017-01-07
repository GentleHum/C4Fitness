//
//  ContentServer.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/22/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit
import Alamofire

public typealias JSONDictionary = [String: AnyObject]

// get all assets
let allAssetsString = "https://cdn.contentful.com/spaces/rqpgj4g1nufm/assets?access_token=a4dd538b7ff205599dccc7481b985549c9569002b97ea348e80721a2e72f4d2a"

// get a single asset
let singleAssetString = "https://cdn.contentful.com/spaces/rqpgj4g1nufm/assets/3hwCOyGB96IS0Ki2WEIgas?access_token=a4dd538b7ff205599dccc7481b985549c9569002b97ea348e80721a2e72f4d2a"


public enum ContentServiceError : Error {
    case unableToConnect(String)
    case invalidInformationRetrieved
    
    public var description: String {
        switch self {
        case .invalidInformationRetrieved:
            return "Invalid content information received from service"
        case .unableToConnect(let networkErrorString):
            return "Error while fetching content from server: \(networkErrorString)"
        }
    }
}


enum DownloadableObjectType {
    case ScheduledClass, Trainer, Testimonial, FitnessClass, StaticContent
    
    var contentString: String {
        let baseURLString = "https://cdn.contentful.com/spaces/rqpgj4g1nufm/entries?access_token=a4dd538b7ff205599dccc7481b985549c9569002b97ea348e80721a2e72f4d2a&content_type="
        switch self {
        case .ScheduledClass: return baseURLString + "startTime"  // should be scheduledClass instead of startTime but made a mistake in Contentful setup
        case .Trainer: return baseURLString + "trainer"
        case .Testimonial: return baseURLString + "testimonial"
        case .FitnessClass: return baseURLString + "fitnessClass"
        case .StaticContent: return baseURLString + "staticContent"
        }
        
    }
}

let mindbodyOnlineString = "https://clients.mindbodyonline.com/classic/ws?studioid=45691&stype=-7&sView=week&sLoc=0"

class ContentServer {
    
    class func downloadModelData(objectType: DownloadableObjectType,
                                 createInstance: @escaping (_ jsonData: JSONDictionary) -> DownloadableDataModel,
                                 completion: @escaping ([DownloadableDataModel], ContentServiceError?) -> Void) {
        
        Alamofire.request(
            objectType.contentString
            )
            .responseJSON { response in
                guard response.result.isSuccess else {
                    completion([DownloadableDataModel](), ContentServiceError.unableToConnect(response.result.error!.localizedDescription))
                    return
                }
                
                guard let jsonResponse = response.result.value as? JSONDictionary,
                    let items = jsonResponse["items"] as? [JSONDictionary] else {
                        completion([DownloadableDataModel](), ContentServiceError.invalidInformationRetrieved)
                        return
                }
                
                var newDataModels = [DownloadableDataModel]()
                for jsonData in items {
                    let newDataModel = createInstance(jsonData)
                    newDataModels.append(newDataModel as DownloadableDataModel)
                }
                
                completion(newDataModels, nil)
        }
        
    }
    
    class func downloadScheduledClasses(_ completion: @escaping ([DownloadableDataModel], ContentServiceError?) -> Void) {
        downloadModelData(objectType: DownloadableObjectType.ScheduledClass,
                          createInstance: ScheduledClassModel.createInstance,
                          completion: completion)
    }

    
    class func downloadTestimonials(_ completion: @escaping ([DownloadableDataModel], ContentServiceError?) -> Void) {
        downloadModelData(objectType: DownloadableObjectType.Testimonial,
                          createInstance: TestimonialModel.createInstance,
                          completion: completion)
    }

    class func downloadTrainers(_ completion: @escaping ([DownloadableDataModel], ContentServiceError?) -> Void) {
        downloadModelData(objectType: DownloadableObjectType.Trainer,
                          createInstance: TrainerModel.createInstance,
                          completion: completion)
    }

    class func downloadFitnessClasses(_ completion: @escaping ([DownloadableDataModel], ContentServiceError?) -> Void) {
        downloadModelData(objectType: DownloadableObjectType.FitnessClass,
                          createInstance: FitnessClassModel.createInstance,
                          completion: completion)
    }

    class func downloadStaticContent(_ completion: @escaping ([DownloadableDataModel], ContentServiceError?) -> Void) {
        downloadModelData(objectType: DownloadableObjectType.StaticContent,
                          createInstance: StaticContentModel.createInstance,
                          completion: completion)
    }

}


