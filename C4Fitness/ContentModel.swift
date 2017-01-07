//
//  ContentModel.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/29/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit


class ContentModel: NSObject {
    private static var staticContentItems: [StaticContentModel] = []
    private static var staticContentDictionary = [String: String] ()
    
    static var testimonials: [TestimonialModel] = []
    static var fitnessClasses: [FitnessClassModel] = []
    static var trainers: [TrainerModel] = []
    static var scheduledClasses: [ScheduledClassModel] = []
    
    static var scheduledClassesLoaded = false
    static var staticContentLoaded = false
    static var testimonialsLoaded = false
    static var fitnessClassesLoaded = false
    static var trainersLoaded = false
    
   
    class var noContractsHeader: String {
        return ContentModel.staticContentDictionary["noContractsHeader"] ?? ""
    }

    class var noContractsText: String {
        return ContentModel.staticContentDictionary["noContractsText"] ?? ""
    }
    
    class var familyVibeHeader: String {
        return ContentModel.staticContentDictionary["familyVibeHeader"] ?? ""
    }
    
    class var familyVibeText: String {
        return ContentModel.staticContentDictionary["familyVibeText"] ?? ""
    }
    
    class var ourAddresseHeader: String {
        return ContentModel.staticContentDictionary["ourAddressHeader"] ?? ""
    }
    
    class var ourAddressText: String {
        return ContentModel.staticContentDictionary["ourAddressText"] ?? ""
    }

    class func loadStaticContentItems(completion: @escaping (ContentServiceError?) -> Void) {
        ContentServer.downloadStaticContent() { (newStaticContentItems, serviceError) in
            guard serviceError == nil else {
                print(serviceError!.description)
                completion(serviceError)
                return
            }
            
            // copy the new static content items  to the content model storage
            staticContentItems = newStaticContentItems as! [StaticContentModel]
            
            // create the dictionary
            for staticContentItem in staticContentItems {
                staticContentDictionary[staticContentItem.label] = staticContentItem.text
            }
            
            completion(nil)
        }
    }
 
    class func loadTestimonials(completion: @escaping (ContentServiceError?) -> Void) {
        ContentServer.downloadTestimonials() { (newTestimonials, serviceError) in
            guard serviceError == nil else {
                print(serviceError!.description)
                completion(serviceError)
                return
            }
            
            // copy the new testimonials to the content model storage
            testimonials = newTestimonials as! [TestimonialModel]
            completion(nil)
        }
        
    }

    class func loadFitnessClasses(completion: @escaping (ContentServiceError?) -> Void) {
        ContentServer.downloadFitnessClasses() { (newFitnessClasses, serviceError) in
            guard serviceError == nil else {
                print(serviceError!.description)
                completion(serviceError)
                return
            }
            
            // copy the new fitness claases to the content model storage
            fitnessClasses = newFitnessClasses as! [FitnessClassModel]
            completion(nil)

        }
    }

    class func loadTrainers(completion: @escaping (ContentServiceError?) -> Void) {
        ContentServer.downloadTrainers() { (newTrainers, serviceError) in
            guard serviceError == nil else {
                print(serviceError!.description)
                completion(serviceError)
                return
            }
            
            // copy the new trainers to the content model storage
            trainers = newTrainers as! [TrainerModel]
            completion(nil)
        }
    }

    class func loadScheduledClasses(completion: @escaping (ContentServiceError?) -> Void) {
        ContentServer.downloadScheduledClasses() { (newScheduledClasses, serviceError) in
            guard serviceError == nil else {
                print(serviceError!.description)
                completion(serviceError)
                return
            }
            
            // copy the new trainers to the content model storage
            scheduledClasses = newScheduledClasses as! [ScheduledClassModel]
            completion(nil)
        }
    }
    
    class func allContentLoaded() -> Bool {
        return scheduledClassesLoaded && staticContentLoaded && testimonialsLoaded && fitnessClassesLoaded && trainersLoaded
    }

    class func loadAllContent(completion: @escaping (ContentServiceError?) -> Void) {
        loadScheduledClasses() { (serviceError) in
            scheduledClassesLoaded = true
            if ContentModel.allContentLoaded() {
                completion(nil)
            }
        }
        loadStaticContentItems() { (serviceError) in
            staticContentLoaded = true
            if ContentModel.allContentLoaded() {
                completion(nil)
            }
        }
        loadTestimonials() { (serviceError) in
            testimonialsLoaded = true
            if ContentModel.allContentLoaded() {
                completion(nil)
            }
        }
        loadFitnessClasses() { (serviceError) in
            fitnessClassesLoaded = true
            if ContentModel.allContentLoaded() {
                completion(nil)
            }
        }
        loadTrainers() { (serviceError) in
            trainersLoaded = true
            if ContentModel.allContentLoaded() {
                completion(nil)
            }
        }
    
    }
    
}
