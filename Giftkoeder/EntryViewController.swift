//
//  EntryViewController.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 15.06.15.
//  Copyright (c) 2015 TeamGK. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class EntryViewController: UIViewController, CLLocationManagerDelegate, UIPopoverControllerDelegate {

    @IBOutlet weak var category: UISegmentedControl!
    @IBOutlet weak var descr: UITextView!
    
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var locationType: UISegmentedControl!
    
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    
    let locationManager = CLLocationManager()
  
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        if locationType.selectedSegmentIndex == 0
        {
            zip.enabled = false
            street.enabled = false
        }
        
        

        
        
        
        
        
    }
    
    @IBAction func addPopover(sender: UIBarButtonItem){
        let popOver = UIPopoverController(contentViewController:self)
     
        
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle{
        return .None
    }
    
    @IBAction func locationIndexChanged(sender:UISegmentedControl)
    {
        switch locationType.selectedSegmentIndex
        {
            case 0:
                zip.enabled = false
                street.enabled = false
                zip.hidden = true
                street.hidden = true
                streetLabel.hidden = true
                zipLabel.hidden = true
            case 1:
                zip.enabled = true
                street.enabled = true
                zip.hidden = false
                street.hidden = false
                streetLabel.hidden = false
                zipLabel.hidden = false
            default:
                break;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
     
        
        switch status {
        case .NotDetermined:
            locationManager.requestAlwaysAuthorization()
            break
            
        case .Authorized:
            self.locationManager.startUpdatingLocation()
            break
            
        case .Denied:
            break
            
        default:
            break
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1/255, green: 200/255, blue: 171/255, alpha: 0.8)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    

    
    @IBAction func saveEntry(sender: AnyObject) {
        
        print("saveEntry")
        
        
        if locationType.selectedSegmentIndex == 0 {
            
            let entry = PFObject(className: "Warnings")
            let lat = self.locationManager.location?.coordinate.latitude
            let long = self.locationManager.location?.coordinate.longitude
            
            
            var location = CLLocation(latitude: lat!, longitude: long!)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                print(location)
                
                if error != nil {
                    print("Reverse geocoder failed with error")
                    return
                }
                
                if let pm = placemarks?.first {
                    let street = pm.name
                    let zip = pm.postalCode
                    let city = pm.locality
                    
                    print(street + " " + zip + " " + city)
                    entry["place"] = PFGeoPoint(latitude: lat!, longitude: long!)
                    entry["zip"] = zip
                    entry["street"] = street
                    entry["city"] = city
                    
                    var categoryString = ""
                    switch self.category.selectedSegmentIndex {
                    case 0:
                        categoryString = "giftkoeder"
                    case 1:
                        categoryString = "scherben"
                    case 2:
                        categoryString = "sonstiges"
                    default:
                        categoryString = "sonstiges"
                    }
                    entry["type"] = categoryString
                    entry["addition"] = self.descr.text
                    
                    entry.saveInBackgroundWithBlock {
                        (success: Bool, error: NSError?) -> Void in
                        if (success) {
                            print("success");
                            print("Update in Entry")
                            Locations.sharedLocations.updateLocations()
                        } else {
                            print("fail");
                        }
                    }
  
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            })
            
            
        }




        
   
        
        else
        {
            let location = street.text! + " " + zip.text!
            CLGeocoder().geocodeAddressString(location, completionHandler: {(placemarks, error) -> Void in
    
                if((error) != nil){
                    print("Error", error)
                    return
                }
                    
                if let pm = placemarks?.first {
                    
                    let entry = PFObject(className: "Warnings")
                    let coord = pm.location.coordinate
                    let lat = coord.latitude
                    let long = coord.longitude
                    
                    let street = pm.name
                    let zip = pm.postalCode
                    let city = pm.locality
                    
                    entry["zip"] = zip
                    entry["street"] = street
                    entry["city"] = city
                    
                    entry["place"] = PFGeoPoint(latitude: lat, longitude: long)
                    
                    var categoryString = ""
                    switch self.category.selectedSegmentIndex {
                    case 0:
                        categoryString = "giftkoeder"
                    case 1:
                        categoryString = "scherben"
                    case 2:
                        categoryString = "sonstiges"
                    default:
                        print("Fehler Switch")
                    }
                    entry["type"] = categoryString
                    entry["addition"] = self.descr.text
                    
                    entry.saveInBackgroundWithBlock {
                        (success: Bool, error: NSError?) -> Void in
                        if (success) {
                            print("success");
                            print("Update in Entry")
                            Locations.sharedLocations.updateLocations()
                        } else {
                            print("fail");
                        }
                    }
                }
                else {
                    print("Problem with the data received from geocoder")
                }
                
            })
        }
        
        
        
        
        
        
        print(entry)
        
        
    }
    



}

