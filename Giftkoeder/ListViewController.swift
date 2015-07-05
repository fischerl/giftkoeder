//
//  ListViewController.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 15.06.15.
//  Copyright (c) 2015 TeamGK. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var listView: UITableView!
    var selectedIndex: NSIndexPath = NSIndexPath();
    
    var radius:Float = 0.0
    var showAllWarnings:Bool = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        var nib = UINib(nibName: "LocationCell", bundle: nil)
        listView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.listView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1/255, green: 200/255, blue: 171/255, alpha: 0.8)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Locations.sharedLocations.list.count
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        

        
        var cell:LocationCell = self.listView.dequeueReusableCellWithIdentifier("cell") as! LocationCell
        
        cell.category.text = Locations.sharedLocations.getItemAtIndex(indexPath.row).street
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        var dateString = dateFormatter.stringFromDate(Locations.sharedLocations.getItemAtIndex(indexPath.row).date)
        cell.date.text = dateString

        switch Locations.sharedLocations.getItemAtIndex(indexPath.row).category {
            case "giftkoeder":
                cell.icon.image = UIImage(named:"giftkoeder_icon")
                break
            case "scherben":
                cell.icon.image  = UIImage(named:"scherben_icon")
                break
            case "sonstiges":
                cell.icon.image  = UIImage(named:"sonstiges_icon")
                break
            default:
                cell.icon.image  = UIImage(named:"sonstiges_icon")
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath
        self.performSegueWithIdentifier("toEntryDetails", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toEntryDetails"
        {
            let vc = segue.destinationViewController as! DetailEntryViewController
            vc.index = selectedIndex.row
        }
        else if segue.identifier == "toSettings" {
            let vc = segue.destinationViewController as! ListSettingsViewController
            vc.radius = self.radius
            vc.showAllWarningsBool = self.showAllWarnings
        }
    }
    



}

