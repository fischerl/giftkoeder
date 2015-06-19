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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var nib = UINib(nibName: "LocationCell", bundle: nil)
        listView.registerNib(nib, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Locations.sharedLocations.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:LocationCell = self.listView.dequeueReusableCellWithIdentifier("cell") as! LocationCell
        
        cell.category.text = Locations.sharedLocations.getItemAtIndex(indexPath.row).category
//        cell.name.text = sharedInstance.getItemAtIndex(indexPath.row).firstname + " " + sharedInstance.getItemAtIndex(indexPath.row).lastname
//        //        cell.lastname.text = sharedInstance.getItemAtIndex(indexPath.row).lastname
//        cell.phonenumber.text = sharedInstance.getItemAtIndex(indexPath.row).phonenumber
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        selectedIndex = indexPath
        self.performSegueWithIdentifier("toContactDetails", sender: self)
    }


}

