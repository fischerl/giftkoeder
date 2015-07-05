//
//  ListSettingsViewController.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 15.06.15.
//  Copyright (c) 2015 TeamGK. All rights reserved.
//

import UIKit


class ListSettingsViewController: UIViewController {
    


    @IBOutlet weak var showRadiusSlider: UISlider!
    @IBOutlet weak var showRadiusLabel: UILabel!
    
    @IBOutlet weak var pushSwitch: UISwitch!
    @IBOutlet weak var pushSlider: UISlider!
    @IBOutlet weak var pushLabel: UILabel!
    @IBOutlet weak var pushRadiusSlider: UISlider!
    @IBOutlet weak var showAllSwitch: UISwitch!
    
    var radius:Float = 0.0
    var showAllWarningsBool:Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showRadiusSlider.value = radius
        showRadiusLabel.text = round(radius).description + " km"
        showAllSwitch.on = showAllWarningsBool
    }
    
    @IBAction func showAllSwitchChanged(sender:UISwitch)
    {
        let vc = self.navigationController?.viewControllers.first as! ListViewController
        if sender.on
        {
            self.showRadiusSlider.tintColor = UIColor.grayColor()
            self.showRadiusSlider.enabled = false
            self.showAllWarningsBool = true
            vc.showAllWarnings = true
        }
        else
        {
            self.showRadiusSlider.tintColor = UIColor(red: 1/255, green: 200/255, blue: 171/255, alpha: 0.8)
            self.showRadiusSlider.enabled = true
            self.showAllWarningsBool = false
            vc.showAllWarnings = false
        }
        
    }
    
    @IBAction func radiusChanged(sender:UISlider)
    {
        let vc = self.navigationController?.viewControllers.first as! ListViewController
        vc.radius = self.showRadiusSlider.value
        self.radius = self.showRadiusSlider.value
        showRadiusLabel.text = round(self.radius).description + " km"
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

