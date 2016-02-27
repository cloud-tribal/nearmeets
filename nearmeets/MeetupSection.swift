//
//  MeetupSection.swift
//  nearmeets
//
//  Copyright © 2016 prop. All rights reserved.
//

import Foundation

struct MeetupSection {
    var date: String
    var meetups: [Meetup]
    
    init(dateString: String, meetupArray: [Meetup]) {
        date = dateString
        meetups = meetupArray
    }
}