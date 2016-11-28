//
//  ContentServer.swift
//  C4Fitness
//
//  Created by Mike Vork on 11/22/16.
//  Copyright © 2016 Mike Vork. All rights reserved.
//

import UIKit
import Alamofire


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
    case ScheduledClass, Trainer, Testimonial, FitnessClass
    
    var contentString: String {
        switch self {
        case .ScheduledClass:
            return "https://cdn.contentful.com/spaces/rqpgj4g1nufm/entries?access_token=a4dd538b7ff205599dccc7481b985549c9569002b97ea348e80721a2e72f4d2a&content_type=startTime"
        case .Trainer:
            return "https://cdn.contentful.com/spaces/rqpgj4g1nufm/entries?access_token=a4dd538b7ff205599dccc7481b985549c9569002b97ea348e80721a2e72f4d2a&content_type=trainer"
        case .Testimonial:
            return "https://cdn.contentful.com/spaces/rqpgj4g1nufm/entries?access_token=a4dd538b7ff205599dccc7481b985549c9569002b97ea348e80721a2e72f4d2a&content_type=testimonial"
        case .FitnessClass:
            return "https://cdn.contentful.com/spaces/rqpgj4g1nufm/entries?access_token=a4dd538b7ff205599dccc7481b985549c9569002b97ea348e80721a2e72f4d2a&content_type=fitnessClass"
        }
        
    }
    
    func createInstance() -> DownloadableDataModel {
        switch self {
        case .ScheduledClass: return ScheduledClassModel()
        case .Trainer: return TrainerModel()
        case .Testimonial: return TestimonialModel()
        case .FitnessClass: return FitnessClassModel()
        }
    }
}


class ContentServer {
    
    class func downloadModelData(objectType: DownloadableObjectType,
                                 completion: @escaping ([DownloadableDataModel], ContentServiceError?) -> Void) {
        
        Alamofire.request(
            objectType.contentString
            )
            .responseJSON { response in
                guard response.result.isSuccess else {
                    completion([DownloadableDataModel](), ContentServiceError.unableToConnect(response.result.error!.localizedDescription))
                    return
                }
                
                guard let jsonResponse = response.result.value as? [String: AnyObject],
                    let items = jsonResponse["items"] as? [[String: AnyObject]] else {
                        completion([DownloadableDataModel](), ContentServiceError.invalidInformationRetrieved)
                        return
                }
                
                var newDataModels = [DownloadableDataModel]()
                for jsonData in items {
                    let newDataModel = objectType.createInstance()
                    newDataModel.set(jsonData: jsonData)
                    newDataModels.append(newDataModel as DownloadableDataModel)
                }
                
                completion(newDataModels, nil)
        }
        
    }
    
    class func downloadScheduledClasses(_ completion: @escaping ([DownloadableDataModel], ContentServiceError?) -> Void) {
        downloadModelData(objectType: DownloadableObjectType.ScheduledClass,
                          completion: completion)
    }

    
    class func downloadTestimonials(_ completion: @escaping ([DownloadableDataModel], ContentServiceError?) -> Void) {
        downloadModelData(objectType: DownloadableObjectType.Testimonial,
                          completion: completion)
    }

    class func downloadTrainers(_ completion: @escaping ([DownloadableDataModel], ContentServiceError?) -> Void) {
        downloadModelData(objectType: DownloadableObjectType.Trainer,
                          completion: completion)
    }

    class func downloadFitnessClasses(_ completion: @escaping ([DownloadableDataModel], ContentServiceError?) -> Void) {
        downloadModelData(objectType: DownloadableObjectType.FitnessClass,
                          completion: completion)
    }

}





/* zap
 func loadScheduledClasses() {
 
 // clear the list
 scheduledClasses.removeAll()
 
 // load the list
 scheduledClasses.append(ScheduledClassModel(name: "Boot Camp",
 date: "11/20/2016",
 startTime: "9:00 AM",
 endTime: "9:45 AM",
 trainerName: "Michelle Christopherson"))
 scheduledClasses.append(ScheduledClassModel(name: "Fit Challenge",
 date: "11/20/2016",
 startTime: "3:00 PM",
 endTime: "4:00 PM",
 trainerName: "Michelle Christopherson"))
 scheduledClasses.append(ScheduledClassModel(name: "Fit Challenge",
 date: "11/20/2016",
 startTime: "5:00 PM",
 endTime: "6:00 PM",
 trainerName: "Eric Scott"))
 scheduledClasses.append(ScheduledClassModel(name: "Muscle Mix",
 date: "11/20/2016",
 startTime: "6:00 PM",
 endTime: "7:00 PM",
 trainerName: "Katie Seier"))
 scheduledClasses.append(ScheduledClassModel(name: "Yoga",
 date: "11/20/2016",
 startTime: "7:00 PM",
 endTime: "8:00 PM",
 trainerName: "Amanda Mroczenski"))
 
 scheduledClasses.append(ScheduledClassModel(name: "Bootcamp X-Treme",
 date: "11/21/2016",
 startTime: "5:00 AM",
 endTime: "5:45 AM",
 trainerName: "Shannon Sappington Hagen"))
 scheduledClasses.append(ScheduledClassModel(name: "X-Force",
 date: "11/21/2016",
 startTime: "6:00 AM",
 endTime: "6:45 AM",
 trainerName: "Shannon Sappington Hagen"))
 scheduledClasses.append(ScheduledClassModel(name: "Lotta Tabata",
 date: "11/21/2016",
 startTime: "1:00 PM",
 endTime: "1:45 PM",
 trainerName: "Crystal Friesz"))
 scheduledClasses.append(ScheduledClassModel(name: "Focus Group",
 date: "11/21/2016",
 startTime: "5:00 PM",
 endTime: "6:00 PM",
 trainerName: "Michelle Christopherson"))
 scheduledClasses.append(ScheduledClassModel(name: "Boot Camp",
 date: "11/21/2016",
 startTime: "6:00 PM",
 endTime: "6:45 PM",
 trainerName: "Traci Slane"))
 scheduledClasses.append(ScheduledClassModel(name: "C4 Fit",
 date: "11/21/2016",
 startTime: "7:00 PM",
 endTime: "7:30 PM",
 trainerName: "Traci Slane"))
 
 scheduledClasses.append(ScheduledClassModel(name: "C4 Sculpt Plus",
 date: "11/22/2016",
 startTime: "5:00 AM",
 endTime: "5:45 AM",
 trainerName: "Traci Slane"))
 scheduledClasses.append(ScheduledClassModel(name: "C4 Sculpt Plus",
 date: "11/22/2016",
 startTime: "6:00 AM",
 endTime: "6:45 AM",
 trainerName: "Traci Slane"))
 scheduledClasses.append(ScheduledClassModel(name: "C4 Sculpt Plus",
 date: "11/22/2016",
 startTime: "1:00 PM",
 endTime: "1:45 PM",
 trainerName: "Michelle Christopherson"))
 scheduledClasses.append(ScheduledClassModel(name: "C4 Sculpt Plus",
 date: "11/22/2016",
 startTime: "5:00 PM",
 endTime: "5:45 PM",
 trainerName: "Traci Slane"))
 scheduledClasses.append(ScheduledClassModel(name: "Fit Challenge",
 date: "11/22/2016",
 startTime: "6:00 PM",
 endTime: "6:45 PM",
 trainerName: "Eric Scott"))
 scheduledClasses.append(ScheduledClassModel(name: "Kettlebell",
 date: "11/22/2016",
 startTime: "7:00 PM",
 endTime: "7:45 PM",
 trainerName: "Kelli Otis"))
 scheduledClasses.append(ScheduledClassModel(name: "Yoga",
 date: "11/22/2016",
 startTime: "8:00 PM",
 endTime: "9:00 PM",
 trainerName: "Amanda Mroczenski"))
 
 scheduledClasses.append(ScheduledClassModel(name: "Bootcamp X-treme",
 date: "11/23/2016",
 startTime: "5:00 AM",
 endTime: "5:45 AM",
 trainerName: "Shannon Sappington Hagen"))
 scheduledClasses.append(ScheduledClassModel(name: "X-Force",
 date: "11/23/2016",
 startTime: "6:00 AM",
 endTime: "6:45 AM",
 trainerName: "Shannon Sappington Hagen"))
 scheduledClasses.append(ScheduledClassModel(name: "Boot Camp",
 date: "11/23/2016",
 startTime: "5:00 PM",
 endTime: "5:45 PM",
 trainerName: "Mollie Bower"))
 scheduledClasses.append(ScheduledClassModel(name: "Boot Camp",
 date: "11/23/2016",
 startTime: "6:00 PM",
 endTime: "6:45 PM",
 trainerName: "Mollie Bower"))
 scheduledClasses.append(ScheduledClassModel(name: "C4 Fit",
 date: "11/23/2016",
 startTime: "7:00 PM",
 endTime: "7:30 PM",
 trainerName: "Mollie Bower"))
 
 scheduledClasses.append(ScheduledClassModel(name: "Beast Before the Feast",
 date: "11/24/2016",
 startTime: "7:30 AM",
 endTime: "8:30 AM",
 trainerName: "Kelli Otis"))
 
 scheduledClasses.append(ScheduledClassModel(name: "Bootcamp X-Treme",
 date: "11/25/2016",
 startTime: "8:00 AM",
 endTime: "8:45 AM",
 trainerName: "Mollie Bower"))
 
 scheduledClasses.append(ScheduledClassModel(name: "Kettlebell",
 date: "11/26/2016",
 startTime: "7:00 AM",
 endTime: "7:45 AM",
 trainerName: "Kelli Otis"))
 scheduledClasses.append(ScheduledClassModel(name: "Boot Camp Plus (1 hour class)",
 date: "11/26/2016",
 startTime: "8:00 AM",
 endTime: "9:00 AM",
 trainerName: "Kelli Otis"))
 scheduledClasses.append(ScheduledClassModel(name: "Bells & Bars",
 date: "11/26/2016",
 startTime: "9:15 AM",
 endTime: "9:45 AM",
 trainerName: "Crystal Friesz"))
 
 
 }
 
 func refreshScheduledClasses() {
 loadScheduledClasses()
 self.tableView.reloadData()
 }
 */


/* zap
 func loadTestimonials() {
 
 // clear the list
 testimonials.removeAll()
 
 // load the list
 testimonials.append(TestimonialModel(name: "Ashley",
 location: "Apple Valley",
 text: "I Enjoy All The Classes Offered And It Challenges Me And My Body To Change. I have tried the big gyms and failed miserably. I believe group fitness is the key to success!"))
 testimonials.append(TestimonialModel(name: "Jeff",
 location: "Apple Valley",
 text: "I’ve already signed up for the next Fit Dads session, and highly encourage anyone who’s feeling run-down, overwhelmed, or just not at the top of their game to give it a shot!"))
 testimonials.append(TestimonialModel(name: "Mick",
 location: "Apple Valley",
 text: "What an amazing place!!! Without you I would not feel as AMAZING as I do!!!"))
 testimonials.append(TestimonialModel(name: "Mary",
 location: "Lakeville",
 text: "You might be wondering why someone with this lack of experience is doing leading the charge on a 5K.Something is in the water there because I don’t even recognize the things I’m doing and am interested in achieving these days!"))
 testimonials.append(TestimonialModel(name: "Jenny",
 location: "Apple Valley",
 text: "Hard-working, fun, non-pretentious environment. A variety of classes and trainers keeps classes fun and ever-changing."))
 testimonials.append(TestimonialModel(name: "Luke",
 location: "Farminington",
 text: "What a great place to get a fantastic all around workout. I weight train but to get the full body, calorie burning, stamina building workout this is the place to be. All the instructors are very nice and fitness knowledgeable, and all the clients are devoted and very nice."))
 testimonials.append(TestimonialModel(name: "Leesa",
 location: "Lakeville",
 text: "Skybound is not only a gym or place to work out, its friendship and family. The trainers are supportive and encouraging, and they make it fun! Every class is different, so it is never boring. Best work outs i have ever had!"))
 testimonials.append(TestimonialModel(name: "Anna",
 location: "Rosemount",
 text: "Skybound is the best place I have worked out....everyone is awesome. I’ve never enjoyed getting my sweat on more!"))
 
 }
 
 func refreshTestimonials() {
 loadTestimonials()
 self.tableView.reloadData()
 }
 */

/* zap
func loadTrainers() {
    
    // clear the list
    trainers.removeAll()
    
    // load the list
    trainers.append(TrainerModel(name: "Michelle Christopherson",
                                 title: "NASM Certified Personal Trainer, Group Fitness Instructor",
                                 imageName: "trainer-michelle.jpg",
                                 details: "My passion for a healthy lifestyle started many years ago through my weight loss journey. This has brought so many wonderful people and new activities into my life. A great motto to live by is: “When one steps outside of their comfort zone is when true growth begins” In 2013, I made the leap … I left the corporate world behind and made the transition to working in the fitness industry. A dream come true! I am a mom of 2 amazing boys, 4 step children and 2 beautiful grandchildren (with another on the way!) In my spare time I enjoy: biking, hiking, working out, kayaking, camping and spending time with my very best friend (my husband)!"))
    trainers.append(TrainerModel(name: "Traci Slane",
                                 title: "Certified Personal Trainer, Group Fitness Instructor",
                                 imageName: "trainer-traci.jpg",
                                 details: "I have been certified as a personal trainer since 2009 as well as certified in group fitness, TRX and kettlebells. I have also spent time as a volunteer running coach. I used to work full time for an insurance company and understand how important time is especially when trying to find balance.\n\nI am a wife and a mother to 2 teenage sons. Our family is very active. My older son loves to run and has completed a few half marathons. My younger son loves mountain biking, weight lifting and triathlons. I used to be an avid runner and have completed 6 marathons and numerous other races. My passion is weight lifting and in May of 2013 competed in my first figure competition. I started powerlifting in 2015 and have competed in four powerlifting competitions in 2016. It is really important to try different things until you find your passion.\n\nWorkouts and getting fit are about making the most of the time you have and making it count. It's all about the quality of the work completed not about quantity of time spent doing it. I enjoy working with people and helping them reach their goals and achieve their dreams."))
    trainers.append(TrainerModel(name: "Shannon Sappington Hagen",
                                 title: "Certified Personal Trainer Bootcamp/HIIT/Kettlebell Instructor",
                                 imageName: "trainer-shannon.jpg",
                                 details: "My husband and I, along with our two children, moved to Minnesota in 2007. The year it snowed in May.\n\nI’ve been a stay-at-home mom for the past 16 years and work approximately 10-12 hours a week instructing Boot Camps and other formats at various locations.\n\nWhen I’m not taking care of my family or training clients I can be found in a gym lifting heavy weights. I’ve been competing since 2012 and was honored last year to have earned an IFPA Pro Card in Master Figure. I’m still training and will be competing in my Pro debut in 2016.\n\nI’m not afraid of hard work and I enjoy getting others to that same mentality. I love watching others achieve success. It’s extremely rewarding as a coach and as a participant to obtain our goals. I look forward to working with all of you at C-4 Fitness and achieving great things."))
    trainers.append(TrainerModel(name: "Crystal Friesz",
                                 title: "NASM Certified Personal Trainer, Group Fitness Instructor",
                                 imageName: "trainer-crystal.jpg",
                                 details: "Crystal is a NASM (National Academy of Sports Medicine) certified trainer.\n\nShe grew up competing in volleyball, golf and taekwondo. As well as competed at the collegic level in golf. Crystal has always had a love for fitness and athletics but really found a new passion for it three years ago.\n\nCrystal is married to Justin, another C-4 Fitness member, and they have three children. She spends her free time refurbishing old furniture and watching fixer upper."))
    trainers.append(TrainerModel(name: "Kelli Otis",
                                 title: "NASM Certified Personal Trainer, Group Fitness & Kettlebell Instructor",
                                 imageName: "trainer-kelli.jpg",
                                 details: "Kelli is a Kettlebell & NASM certified instructor and one of the most energetic, bubbly people you will ever meet! She is full of drive, passion and humor with an infectious personality! Fitness has been a huge part or her and her family’s life as it is very important for her to be a strong role model to her two beautiful daughters. Kelli has been married to Josh (another C4 Fitness member) for nearly 14 years. They enjoy family vacations and attending their daughter’s activities. Kelli has always felt a passion for teaching and writing fitness programs."))
    trainers.append(TrainerModel(name: "Mollie Bower",
                                 title: "NASM Certified Personal Trainer, Group Fitness Instructor",
                                 imageName: "trainer-mollie.jpg",
                                 details: "Mollie has been passionate about health and fitness for many years, and recently decided to take the leap to be a Trainer!\n\nShe believes in fitness and health as a lifelong commitment, not just something you do to fit into your jeans. While her husband might say she has an addiction to working out, she would say it is an addiction to being healthy and pushing the limits of her own body. She believes you have to live in moderation and she will never say no to ice cream!\n\nMollie works full-time outside of teaching classes, and is married to John with two teenagers (Karlie and Brady). She spends her free time with them, hanging with their zoo (Rugby, Tucker and Ripley) and bingeing on the occasional Netflix series.\n\nBe warned. Her classes will not be easy. Her motto is “Live outside the Comfort Zone”, believing that the most impactful times in our lives are the ones that make us a little uncomfortable. Get comfortable with the uncomfortable!"))
    trainers.append(TrainerModel(name: "Katie Seier",
                                 title: "Turbo Kick/PiYo/Cize Instructor, ACE Certified Trainer",
                                 imageName: "trainer-katie.jpg",
                                 details: "Katie grew up in Minot North Dakota and now lives in Burnsville with her boyfriend and jack Russell terrier named Darby. She started teaching classes at age 19 in college where she graduated from Minot State University with a B.S. in corporate fitness.\n\nKatie holds ACE Certified Personal Trainer and AFAA Group Fitness Instructor certifications as well as various specialty group fitness formats. Katie also works at Fabletics at the Mall of America part time."))
    trainers.append(TrainerModel(name: "Eric Scott",
                                 title: "NASM CPT, Fit Dad’s Trainer",
                                 imageName: "trainer-eric.jpg",
                                 details: "I understand the challenges that so many face trying to achieve a healthy lifestyle because I’ve faced the same issues, struggling with weight and an unhealthy relationship with food throughout my adult life. It was through my relationship with C4 Fitness that I learned to become healthy, lost weight, gained strength and began to love fitness. I turned my newfound passion outward and have gone from participant to trainer for the Fit Father’s group. When I am not in the gym - either as a participant or facilitator - I am a parent and grandparent, a youth mentor, a frequent volunteer and an avid Obstacle Course racer."))
}

func refreshTrainers() {
    loadTrainers()
    self.tableView.reloadData()
}

*/
