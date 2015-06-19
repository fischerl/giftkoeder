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

class MapViewController: UIViewController {

    
    @IBOutlet weak var googleMap: GMSMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Google Map
        let camera = GMSCameraPosition.cameraWithLatitude(48.0999311,
            longitude:11.5181916, zoom:12)
        googleMap.camera = camera
        
//        print("Update in viewDidLoad")
//        Locations.sharedLocations.updateLocations()
        
//    var markerCount = 0
//        for loc in Locations.sharedLocations.list
//        {
//            let marker = GMSMarker()
//            marker.position =  CLLocationCoordinate2D(latitude:loc.latitude,longitude:loc.longitude)
//            marker.snippet = loc.descr
//            marker.appearAnimation = kGMSMarkerAnimationPop
//            marker.map = self.googleMap
//            markerCount++
//        }
//        print("Marker Count in viewDidLoad")
//        print(markerCount)
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
//        print("Update in viewWillApear")
//        Locations.sharedLocations.updateLocations()
        
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        print("Update in vieDidAppear")
        Locations.sharedLocations.updateLocations()
        
        var markerCount = 0
        for loc in Locations.sharedLocations.list
        {
            let marker = GMSMarker()
            
            marker.position =  CLLocationCoordinate2D(latitude:loc.latitude,longitude:loc.longitude)
            marker.icon = UIImage(named: "marker")
            marker.snippet = loc.descr
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.map = self.googleMap
            markerCount++
        }
        print("Marker Count in viewDidAppear")
        print(markerCount)
    }
    

    
    

    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



  
}

