//
//  EntryViewController.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 15.06.15.
//  Copyright (c) 2015 TeamGK. All rights reserved.
//

import UIKit
import Parse

class EntryViewController: UIViewController {

    @IBOutlet weak var test: UIButton!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var category: UISegmentedControl!
    @IBOutlet weak var descr: UITextView!
    @IBOutlet weak var save: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveEntry(sender: UIButton) {
        var entry = PFObject(className: "Entry")
        entry["location"] = PFGeoPoint(latitude: 48.1497539, longitude: 11.5944009)
        var categoryString = ""
        switch category.selectedSegmentIndex {
            case 0:
                categoryString = "giftkoeder"
            case 1:
                categoryString = "scherben"
            case 2:
                categoryString = "sonstiges"
            default:
                print("Fehler Switch")
        }
        entry["category"] = categoryString
        entry["description"] = descr.text
        
        entry.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("success");
            } else {
                // There was a problem, check error.description
                print("fail");
            }
        }
        
    }
    
    @IBAction func generateTestEntry(sender: UIButton) {
        
        var entry = PFObject(className:"Entry")
        entry["description"] = "desc desc desc desc desc desc desc "
        entry["category"] = "giftkoeder"
        entry["location"] = PFGeoPoint(latitude: 48.1497541, longitude: 11.5944003)
            
        entry.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("success");
            } else {
                // There was a problem, check error.description
                print("fail");
            }
        }
    }


}

