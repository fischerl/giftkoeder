//
//  DetailEntryViewController.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 20.06.15.
//  Copyright © 2015 TeamGK. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import AddressBookUI

class DetailEntryViewController: UIViewController {
    
    var index:Int?
    
    @IBOutlet weak var locationText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var detailsTitle: UINavigationItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        detailsTitle.title = Locations.sharedLocations.getItemAtIndex(index!).category.capitalizedString.stringByReplacingOccurrencesOfString("oe", withString: "ö")
        
        var longitude :CLLocationDegrees = Locations.sharedLocations.getItemAtIndex(index!).longitude
        var latitude :CLLocationDegrees = Locations.sharedLocations.getItemAtIndex(index!).latitude
        
        var location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
//        println(location)
        
        
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            
            if error != nil {
                print("Reverse geocoder failed with error")
                return
            }
            
            if let pm = placemarks?.first {
                let name:String = pm.addressDictionary["Name"]! as! String
                let zip:String = pm.addressDictionary["ZIP"]! as! String
                let city:String = pm.addressDictionary["SubAdministrativeArea"]! as! String
                let locationString = name + ", " + zip + " " + city
                
                self.locationText.text =  locationString
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy hh:mm"
        var dateString = dateFormatter.stringFromDate(Locations.sharedLocations.getItemAtIndex(index!).date)
        dateText.text = dateString
        descriptionText.text = Locations.sharedLocations.getItemAtIndex(index!).descr
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
    

    
}
