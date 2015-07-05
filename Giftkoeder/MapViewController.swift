//
//  MapViewController.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 15.06.15.
//  Copyright (c) 2015 TeamGK. All rights reserved.
//

import UIKit
import Parse
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    

    @IBOutlet weak var googleMap: GMSMapView!
  
    let locationManager = CLLocationManager()
    
    var mapType = "standard"
    var mapRadius:Float = 0.0
    var showAllWarnings:Bool = false
    
    // New Variables
    var mapPushRadius:Float = 0.0
    var pushIsOn:Bool = false

    // Background LocationManager
    /*lazy var locationManager2: CLLocationManager! = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        return manager
        }()*/

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Google Map
        let camera = GMSCameraPosition.cameraWithLatitude(48.0999311,
            longitude:11.5181916, zoom:12)
        googleMap.camera = camera
        switch mapType {
            case "standard":
                googleMap.mapType = kGMSTypeNormal
            case "satellit":
                googleMap.mapType = kGMSTypeSatellite
            case "hybrid":
                googleMap.mapType = kGMSTypeHybrid
            default:
                googleMap.mapType = kGMSTypeNormal
        }
        
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

    }
    
    public func setGoogleMapType(type:String)
    {
        self.mapType = type
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSettings" {
            let vc = segue.destinationViewController as! SettingsViewController
            vc.mapTypeString = self.mapType
            vc.mapRadius = self.mapRadius
            vc.showAllWarningsBool = self.showAllWarnings
            
            vc.mapPushRadius = self.mapPushRadius
            vc.pushIsOn = self.pushIsOn
        }
    }

    
    override func viewWillAppear(animated: Bool)
    {

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1/255, green: 200/255, blue: 171/255, alpha: 0.8)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 20)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        switch mapType {
        case "standard":
            googleMap.mapType = kGMSTypeNormal
        case "satellit":
            googleMap.mapType = kGMSTypeSatellite
        case "hybrid":
            googleMap.mapType = kGMSTypeHybrid
        default:
            googleMap.mapType = kGMSTypeNormal
        }

    }
    
    override func viewDidAppear(animated: Bool)
    {
        self.googleMap.clear()
        
        // Start Background Thread for Localization
        if (pushIsOn){
            print("Push is on with radius:")
            print(mapPushRadius)
            locationManager.startUpdatingLocation()
        } else {
            print("Push is off")
            locationManager.stopUpdatingLocation()
        }
        
        for loc in Locations.sharedLocations.list
        {
            let locationPoint = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
//            let latUser = self.locationManager.location?.coordinate.latitude
//            let longUser = self.locationManager.location?.coordinate.longitude
//            let locationUser = CLLocation(latitude: latUser!  as! CLLocationDegrees, longitude: longUser! as! CLLocationDegrees)
//            let distance = locationPoint.distanceFromLocation(locationUser)

//                if  self.showAllWarnings || Float(distance) < self.mapRadius*1000
//                {
                    let marker = GMSMarker()
                    
                    marker.position =  CLLocationCoordinate2D(latitude:loc.latitude,longitude:loc.longitude)
                    switch loc.category {
                    case "giftkoeder":
                        marker.icon = UIImage(named:"giftkoeder_place")
                    case "scherben":
                        marker.icon = UIImage(named:"scherben_place")
                    case "sonstiges":
                        marker.icon = UIImage(named:"sonstiges_place")
                    default:
                        marker.icon = UIImage(named:"sonstiges_place")
                    }
                    marker.snippet = loc.street + ", " + loc.zip + " " + loc.city  + "\n" + loc.descr
                    marker.appearAnimation = kGMSMarkerAnimationPop
                    marker.map = self.googleMap
                
//            }
            
        }
            
        
//        let self_lat = self.locationManager.location?.coordinate.latitude
//        let self_long = self.locationManager.location?.coordinate.longitude
//        
//
//            let self_marker = GMSMarker()
//            self_marker.position = CLLocationCoordinate2D(latitude: self_lat!, longitude: self_long!)
//            self_marker.icon = UIImage(named:"location")
//            self_marker.map = self.googleMap
        
        
    }
    
    // Handle new Background Positions
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {

        //let locationPoint = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
        let zaehler:Int = 0
        
        // If App is in BAckground
        if UIApplication.sharedApplication().applicationState == .Active {
        } else {
            // Search for a Location in Push Radius
            for loc in Locations.sharedLocations.list
            {
                
                let locationPoint = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
                let distance = locationPoint.distanceFromLocation(newLocation)
                
                if  Float(distance) < self.mapPushRadius
                {
                    zaehler+1
                }
            }
            // If there is one, create a Push to inform User
            if zaehler > 0 {
                // PUSH Nachricht
            }
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



  
}



