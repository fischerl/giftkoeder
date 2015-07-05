//
//  ListSettingsViewController.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 15.06.15.
//  Copyright (c) 2015 TeamGK. All rights reserved.
//

import UIKit


class ListSettingsViewController: UIViewController {
    

    @IBOutlet weak var showRadius: UISlider!
    @IBOutlet weak var showRadiusText: UILabel!
    @IBOutlet weak var showAll: UISwitch!
    @IBOutlet weak var pushSwitch: UISwitch!
    @IBOutlet weak var pushRadiusSlider: UISlider!
    @IBOutlet weak var pushRadiusText: UILabel!
    
    var radius:Float = 0.0
    var showAllWarningsBool:Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showRadius.value = radius
        showRadiusText.text = round(radius).description + " km"
        showAll.on = showAllWarningsBool
    }
    
    @IBAction func showAllSwitchChanged(sender:UISwitch)
    {
        let vc = self.navigationController?.viewControllers.first as! ListViewController
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
    
    @IBAction func radiusChanged(sender:UISlider)
    {
        let vc = self.navigationController?.viewControllers.first as! ListViewController
        vc.radius = self.showRadius.value
        self.radius = self.showRadius.value
        showRadiusText.text = round(self.radius).description + " km"
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

