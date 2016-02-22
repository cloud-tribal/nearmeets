//
//  MeetupSection.swift
//  nearmeets
//
//  Created by Anyss Hamza on 2016-02-21.
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