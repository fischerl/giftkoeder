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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Google Map
        let camera = GMSCameraPosition.cameraWithLatitude(48.0999311,
            longitude:11.5181916, zoom:12)
        googleMap.camera = camera
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1/255, green: 200/255, blue: 171/255, alpha: 0.8)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 20)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        

    }
    
    override func viewDidAppear(animated: Bool)
    {
        self.googleMap.clear()
        
        
        
        
        for loc in Locations.sharedLocations.list
        {
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
        }
        
        let self_lat = self.locationManager.location?.coordinate.latitude
        let self_long = self.locationManager.location?.coordinate.longitude
        
        if CLLocationManager.authorizationStatus() == .Authorized {
            let self_marker = GMSMarker()
            self_marker.position = CLLocationCoordinate2D(latitude: self_lat!, longitude: self_long!)
            self_marker.icon = UIImage(named:"location")
            self_marker.map = self.googleMap
        }
        
    }
    

    
    

    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



  
}

