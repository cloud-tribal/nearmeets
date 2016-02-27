//
//  OnboardVC.swift
//  nearmeets
//
//  Copyright © 2016 prop. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import Spring
import SwiftLoader

class OnboardVC: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var compass: SpringImageView!
    @IBOutlet weak var textToDisappear: SpringTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .NotDetermined:
            break
        case .AuthorizedAlways:
            break
        case .Restricted:
            dismissViewControllerAnimated(true, completion: nil)
            break
        case .Denied:
            dismissViewControllerAnimated(true, completion: nil)
            break
        case .AuthorizedWhenInUse:
            textToDisappear.animation = "fadeOut"
            textToDisappear.animate()
            SwiftLoader.show(animated: true)
            locationManager.requestLocation()
            break
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])  {
        var coordinateArray: NSArray?
        
        if let firstLocation = locations.first {
            if let latitude = firstLocation.coordinate.latitude as? Double, longitude = firstLocation.coordinate.longitude as? Double {
                coordinateArray = [latitude, longitude]
            }
            
            LocationManager.instance.userLocation = firstLocation
            
            fetchMeetups(firstLocation.coordinate.latitude, lon: firstLocation.coordinate.longitude, complete: { meetups, error in
                if error != nil {
                    print(error)
                } else if let meetups = meetups {
                    MeetupManager.instance.meetupSections = buildMeetupSections(meetups)
                    SwiftLoader.hide()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location update failed \(error)")
    }
    
    @IBAction func requestLocation(sender: AnyObject) {
        locationManager.requestWhenInUseAuthorization()

    }
}