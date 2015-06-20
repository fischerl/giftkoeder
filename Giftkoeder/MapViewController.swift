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
        print("Update in vieDidAppear")
        Locations.sharedLocations.updateLocations()
        
        var markerCount = 0
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

