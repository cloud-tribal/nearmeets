//
//  MeetupCell.swift
//  meetSoon
//
//  Created by Anyss Hamza on 2016-02-20.
//  Copyright © 2016 prop. All rights reserved.
//

import UIKit
import Alamofire

class MeetupCell: UITableViewCell {

    @IBOutlet weak var meetupCard: UIVisualEffectView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var hosts: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var amOrPm: UILabel!
    @IBOutlet weak var timeBox: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        meetupCard.layer.cornerRadius = 6.0
        meetupCard.clipsToBounds = true
        meetupCard.layer.borderColor = UIColor.whiteColor().CGColor
        meetupCard.layer.borderWidth = 2.0
        
        timeBox.layer.cornerRadius = 4.0
        timeBox.clipsToBounds = true
    }

    func configureCell(meetup: Meetup) {
        title.text = meetup.title
        hosts.text = meetup.hosts
        if let meetupAddress = meetup.address {
            address.text = meetupAddress
        }
        
        let formatter = NSDateFormatter()
        
        formatter.dateFormat = "h:mm"
        let timeString = formatter.stringFromDate(meetup.date)
        time.text = timeString
        
        formatter.dateFormat = "a"
        let amOrPmString = formatter.stringFromDate(meetup.date)
        amOrPm.text = amOrPmString
    }
}
