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

    class func loadStaticContentItems() {
        ContentServer.downloadStaticContent() { (newStaticContentItems, serviceError) in
            guard serviceError == nil else {
                print(serviceError!.description)
                return
            }
            
            // copy the new static content items  to the content model storage
            staticContentItems = newStaticContentItems as! [StaticContentModel]
            
            // create the dictionary
            for staticContentItem in staticContentItems {
                staticContentDictionary[staticContentItem.label] = staticContentItem.text
            }
        }
    }
 
    class func loadTestimonials() {
        ContentServer.downloadTestimonials() { (newTestimonials, serviceError) in
            guard serviceError == nil else {
                print(serviceError!.description)
                return
            }
            
            // copy the new testimonials to the content model storage
            testimonials = newTestimonials as! [TestimonialModel]
        }
        
    }

    class func loadFitnessClasses() {
        ContentServer.downloadFitnessClasses() { (newFitnessClasses, serviceError) in
            guard serviceError == nil else {
                print(serviceError!.description)
                return
            }
            
            // copy the new fitness claases to the content model storage
            fitnessClasses = newFitnessClasses as! [FitnessClassModel]
        }
    }

    class func loadTrainers() {
        ContentServer.downloadTrainers() { (newTrainers, serviceError) in
            guard serviceError == nil else {
                print(serviceError!.description)
                return
            }
            
            // copy the new trainers to the content model storage
            trainers = newTrainers as! [TrainerModel]
        }
    }

    class func loadScheduledClasses() {
        ContentServer.downloadScheduledClasses() { (newScheduledClasses, serviceError) in
            guard serviceError == nil else {
                print(serviceError!.description)
                return
            }
            
            // copy the new trainers to the content model storage
            scheduledClasses = newScheduledClasses as! [ScheduledClassModel]
        }
    }

    class func loadAllContent(completion: @escaping () -> Void) {
        
        print("in downloadAllContent") // zap
        loadStaticContentItems()
        loadTestimonials()
        loadFitnessClasses()
        loadTrainers()
// zap        loadScheduledClasses()
        print("done reading content")  // zap

    }
    
}
