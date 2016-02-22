//
//  Meetups.swift
//  meetSoon
//
//  Created by Anyss Hamza on 2016-02-19.
//  Copyright © 2016 prop. All rights reserved.
//

import Foundation
import CoreLocation

class Meetup {
    
    private var _title: String!
    private var _hosts: String!
    private var _date: NSDate!
    private var _address: String?
    private var _coordinates: (Double, Double)?
    private var _description: String!
    private var _groupPhoto: String?
    
    init(title: String, hosts: String, date: NSDate, description: String, address: String?, coordinates: (Double, Double)?, groupPhoto: String?) {
        self._title = title
        self._hosts = hosts
        self._date = date
        self._description = description
        self._address = address
        self._coordinates = coordinates
        self._groupPhoto = groupPhoto
    }
    
    var title: String {
        return _title
    }
    
    var hosts: String {
        return _hosts
    }
    
    var date: NSDate {
        return _date
    }
    
    var day: String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        formatter.timeStyle = .NoStyle
        let readableDay = formatter.stringFromDate(date)
        
        return readableDay
    }
    
    var time: String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .NoStyle
        formatter.timeStyle = .MediumStyle
        let readableTime = formatter.stringFromDate(date)
        
        return readableTime
    }
    
    var address: String? {
        return _address
    }
    
    var coordinates: (Double, Double)? {
        return _coordinates
    }
    
    var description: String {
        return _description
    }
    
    var groupPhoto: String? {
        return _groupPhoto
    }    
}