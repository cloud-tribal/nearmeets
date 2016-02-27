//
//  MeetupManager.swift
//  nearmeets
//
//  Copyright © 2016 prop. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MeetupManager {

    static var instance = MeetupManager()
    
    var meetupSections = [MeetupSection]()
    var meetupsFetched = false
}

func fetchMeetups(lat: Double, lon: Double, complete: (meetups: [Meetup]?, error: NSError?) -> Void ) {
    
    let url = "https://api.meetup.com/2/open_events?sign=true&text_format=plain&lat=\(lat)&lon=\(lon)&radius=25.0&category=34&key=\(API_KEY)"

    
    Alamofire.request(.GET, url).response { response in
        
        if response.3 != nil {
            complete(meetups: [], error: response.3)
            
        } else if let responseData = response.2 {
            let meetupsJSON = JSON(data: responseData)
            
            if meetupsJSON.isEmpty {
                let emptyResponseError = NSError(domain: "emptyResponse", code: 0, userInfo: nil)
                complete(meetups: [], error: emptyResponseError)
                
            } else {
                if meetupsJSON["code"] == "not_authorized" {
                    let notAuthorizedError = NSError(domain: "notAuthorized", code: 1, userInfo: nil)
                    complete(meetups:[], error: notAuthorizedError)
                }
                let meetups = parseMeetups(meetupsJSON)
                complete(meetups: meetups, error: nil)
            }
        }
    }
}

func parseMeetups(jsonDict: JSON) -> [Meetup] {
    var meetups: [Meetup] = []
    let results = jsonDict["results"] as JSON
    
    for (_,subJSON):(String,JSON) in results {
        let title = subJSON["name"].stringValue
        let hosts = subJSON["group"]["who"].stringValue
        let date = NSDate(timeIntervalSince1970: subJSON["time"].doubleValue/1000)
        let address = subJSON["venue"]["address_1"].string
        let lat = subJSON["venue"]["lat"].doubleValue
        let lon = subJSON["venue"]["lon"].doubleValue
        
        let description = subJSON["description"].stringValue.stringByReplacingOccurrencesOfString("&nbsp;", withString: " ")

        let groupPhoto = subJSON["group"]["photo_sample"]["photo_link"].string
        
        let meetup = Meetup(title: title, hosts: hosts, date: date, description: description, address: address, coordinates: (lat, lon) , groupPhoto: groupPhoto)

        meetups.append(meetup)
    }
    return meetups
}

func buildMeetupSections(meetups: [Meetup]) -> [MeetupSection] {
    var meetupSections = [MeetupSection]()

    for meetup in meetups {
        let meetupSectionIndex = meetupSections.indexOf({ $0.date == meetup.day })

        if let index = meetupSectionIndex {
            meetupSections[index].meetups.append(meetup)
        
        } else {
            let newMeetupSection = MeetupSection(dateString: meetup.day, meetupArray: [meetup])
            meetupSections.append(newMeetupSection)
        }
    }
    MeetupManager.instance.meetupSections = meetupSections
    return meetupSections
}