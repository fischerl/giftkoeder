//
//  SettingsViewController.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 15.06.15.
//  Copyright (c) 2015 TeamGK. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {

    @IBOutlet weak var showRadius: UISlider!
    @IBOutlet weak var showRadiusText: UILabel!
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var pushOnOff: UISwitch!
    @IBOutlet weak var pushRadius: UISlider!
    @IBOutlet weak var pushRadiusText: UILabel!
    @IBOutlet weak var showAllWarnings: UISwitch!
    
    var mapTypeString:String!
    var mapRadius:Float = 0.0
    var showAllWarningsBool:Bool = false
    
    var mapPushRadius:Float = 0.0
    var pushIsOn:Bool = false
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(self.mapTypeString)
        switch self.mapTypeString {
            case "standard":
            mapType.selectedSegmentIndex = 0
            case "satellit":
            mapType.selectedSegmentIndex = 1
            case "hybrid":
            mapType.selectedSegmentIndex = 2
        default:
            mapType.selectedSegmentIndex = 0
        }
        showRadius.value = mapRadius
        showRadiusText.text = round(mapRadius).description + " km"
        pushRadiusText.text = round(mapPushRadius).description + " m"
        showAllWarnings.on = showAllWarningsBool
        
        pushRadius.value = mapPushRadius
        pushOnOff.on = pushIsOn

    
        


        
    }
    
    @IBAction func showAllSwitchChanged(sender:UISwitch)
    {
        let vc = self.navigationController?.viewControllers.first as! MapViewController
        if sender.on
        {
            self.showRadius.tintColor = UIColor.grayColor()
            self.showRadius.enabled = false
            self.showAllWarningsBool = true
            vc.showAllWarnings = true
        }
        else
        {
            self.showRadius.tintColor = UIColor(red: 1/255, green: 200/255, blue: 171/255, alpha: 0.8)
            self.showRadius.enabled = true
            self.showAllWarningsBool = false
            vc.showAllWarnings = false
        }
        
    }
    
    // Same as ShowAllWarnings for Push
    @IBAction func pushSwitchChanged(sender:UISwitch)
    {
        let vc = self.navigationController?.viewControllers.first as! MapViewController
        if sender.on
        {
            self.pushRadius.tintColor = UIColor(red: 1/255, green: 200/255, blue: 171/255, alpha: 0.8)
            self.pushRadius.enabled = true
            self.pushIsOn = true
            vc.pushIsOn = true
        }
        else
        {
            self.pushRadius.tintColor = UIColor.grayColor()
            self.pushRadius.enabled = false
            self.pushIsOn = false
            vc.pushIsOn = false
        }
        
    }
    
    @IBAction func mapRadiusChanged(sender:UISlider) {
        let vc = self.navigationController?.viewControllers.first as! MapViewController
        vc.mapRadius = showRadius.value
        self.mapRadius = showRadius.value
        showRadiusText.text = round(mapRadius).description + " km"
    }

    // Same as mapRadiusChanged for Push
    @IBAction func pushRadiusChanged(sender:UISlider) {
        let vc = self.navigationController?.viewControllers.first as! MapViewController
        vc.mapPushRadius = pushRadius.value
        self.mapPushRadius = pushRadius.value
        pushRadiusText.text = round(mapPushRadius).description + " m"
    }
    
    @IBAction func indexChanged(sender:UISegmentedControl) {
        let vc = self.navigationController?.viewControllers.first as! MapViewController
        print(vc.mapType)
        switch mapType.selectedSegmentIndex {
        case 0:
            vc.mapType = "standard"
        case 1:
            vc.mapType = "satellit"
        case 2:
            vc.mapType = "hybrid"
        default:
            vc.mapType = "standard"
        }
        print(vc.mapType)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    
    
    

    

    


}

