//
//  LaunchVC.swift
//  nearmeets
//
//  Copyright © 2016 prop. All rights reserved.
//

import UIKit
import CoreLocation

class LaunchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        let status = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            performSegueWithIdentifier("enterSegue", sender: self)            
        } else if status == CLAuthorizationStatus.NotDetermined {
            performSegueWithIdentifier("onboardSegue", sender: self)            
        } else if status == CLAuthorizationStatus.Denied {
            performSegueWithIdentifier("deniedSegue", sender: self)
        }
    }
}
