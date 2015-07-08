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

class EntryViewController: UIViewController, CLLocationManagerDelegate, UIPopoverControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var category: UISegmentedControl!
    @IBOutlet weak var descr: UITextView!
    
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var locationType: UISegmentedControl!
    
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var ortLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!

    
    @IBOutlet weak var content: UIView!
    
    let locationManager = CLLocationManager()
  
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        print(PFUser.currentUser())
        



        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        if locationType.selectedSegmentIndex == 0
        {
            zip.enabled = false
            street.enabled = false
        }
        
        descr.delegate = self
        zip.delegate = self
        street.delegate = self

        let recognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        content.addGestureRecognizer(recognizer)
    }
    
    func handleTap(recognizer: UITapGestureRecognizer)
    {
        descr.resignFirstResponder()
        zip.resignFirstResponder()
        street.resignFirstResponder()
        
        println("tappped")
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
            
        case .AuthorizedAlways:
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
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 20)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        if PFUser.currentUser() == nil
        {
            self.category.hidden = true
            self.category.enabled = false
            
            self.descr.hidden = true
            
            self.zip.hidden = true
            self.zip.enabled = false
            
            self.street.hidden = true
            self.street.enabled = false
            
            self.locationType.hidden = true
            self.locationType.enabled = false
            
            self.zipLabel.hidden = true
            self.streetLabel.hidden = true
            self.ortLabel.hidden = true
            self.categoryLabel.hidden = true
            self.descriptionLabel.hidden = true
            
            self.warningLabel.hidden = false
            
            self.saveButton.enabled = false
            self.saveButton.hidden = true
        }
        else
        {
            self.category.hidden = false
            self.category.enabled = true
            
            self.descr.hidden = false
            
            if self.locationType.selectedSegmentIndex == 1
            {
                self.zip.hidden = false
                self.zip.enabled = true
                
                self.street.hidden = false
                self.street.enabled = true
                
                self.zipLabel.hidden = false
                self.streetLabel.hidden = false
            }
            
            self.locationType.hidden = false
            self.locationType.enabled = true
            
            self.ortLabel.hidden = false
            self.categoryLabel.hidden = false
            self.descriptionLabel.hidden = false
            
            self.warningLabel.hidden = true
            
            self.saveButton.enabled = true
            self.saveButton.hidden = false
        }
    }
    


 
    
    
    

    
    @IBAction func saveEntry(sender: AnyObject)
    {
        if locationType.selectedSegmentIndex == 0
        {
            
            let entry = PFObject(className: "Warnings")
            let lat = self.locationManager.location?.coordinate.latitude
            let long = self.locationManager.location?.coordinate.longitude
            
            
            var location = CLLocation(latitude: lat!, longitude: long!)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                print(location)
                
                if error != nil
                {
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
                else
                {
                    print("Problem with the data received from geocoder")
                }
            })
            
            
        }




        
   
        
        else
        {
            let location = street.text! + " " + zip.text!
            CLGeocoder().geocodeAddressString(location, completionHandler: {(placemarks, error) -> Void in
    
                if((error) != nil)
                {
                    print("Error", error)
                    return
                }
                    
                if let pm = placemarks?.first as? CLPlacemark
                {
                    
                    let entry = PFObject(className: "Warnings")
                    let coord = pm.location.coordinate
                    //let coord = pm.location
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
                else
                {
                    print("Problem with the data received from geocoder")
                }
                
            })
        }
        
    }
    



}

