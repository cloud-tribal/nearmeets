 //
//  MeetupsVC.swift
//  meetSoon
//
//  Created by Anyss Hamza on 2016-02-19.
//  Copyright © 2016 prop. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftLoader
 
class MeetupsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var locationManager = CLLocationManager()
    var userLocation: CLLocation!
    
    var meetupList = [Meetup]()
    var meetupSections = [MeetupSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    override func viewDidAppear(animated: Bool) {
        if !MeetupManager.instance.meetupSections.isEmpty {
            meetupSections = MeetupManager.instance.meetupSections
            tableView.reloadData()
        } else {
            locationManager.requestLocation()
            SwiftLoader.show(animated: true)
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            userLocation = firstLocation
            LocationManager.instance.userLocation = firstLocation
            fetchMeetups(userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude) { meetups, error in
                if error != nil {
                    print("Error fetching meetups :\(error)")
                    if error!.code == 1 {
                        self.presentErrorMessage()
                    }
                }
                if let meetups = meetups {
                    self.meetupList = meetups
                    self.meetupSections = buildMeetupSections(meetups)
                    SwiftLoader.hide()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error fetching location: \(error)")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let meetup = meetupSections[indexPath.section].meetups[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MeetupCell") as! MeetupCell
        
        cell.configureCell(meetup)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetupSections[section].meetups.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return meetupSections.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return meetupSections[section].date
    }
    
    func presentErrorMessage() {
        let alertController = UIAlertController(title: "You need to input your meetups.com API key!", message: "Just stick it in the API_KEY variable in Key.swift", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Default, handler: { uiAlertAction -> Void in }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}