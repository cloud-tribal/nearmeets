//
//  DeniedVC.swift
//  nearmeets
//
//  Created by Anyss Hamza on 2016-02-22.
//  Copyright © 2016 prop. All rights reserved.
//

import UIKit
import CoreLocation

class DeniedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground", name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    func applicationWillEnterForeground() {        
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func goToSettings(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string:"prefs:root=LOCATION_SERVICES")!)
    }
}
