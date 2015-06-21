//
//  Locations.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 19.06.15.
//  Copyright © 2015 TeamGK. All rights reserved.
//

import Foundation
import Parse

let SharedLocations = Locations()


class Locations
{
    var list:[Location] = [Location]()
    
    class var sharedLocations:Locations {
        return SharedLocations
    }
    
    init()
    {
        list = [Location]()
        let query = PFQuery(className:"Warnings")
        var objects = query.findObjects()
        for object in objects!
        {
            let addition = object["addition"]! as! String
            let lat = object["place"]!!.latitude as Double
            let long = object["place"]!!.longitude as Double
            let type = object["type"]! as! String
            let locationId = object.objectId!! as String
            let date = object.createdAt!! as NSDate
            let street = object["street"]! as! String
            let zip = object["zip"]! as! String
            let city = object["city"]! as! String
            
            let loc = Location(latitude: lat, longitude: long, descr: addition, category: type, id: locationId, date:date, street:street, zip:zip, city:city)
            list.append(loc)
        }
    }
    
    public func updateLocations()
    {
        print("update")
        list = [Location]()
        let query = PFQuery(className:"Warnings")
        var objects = query.findObjects()
        for object in objects!
        {
            let addition = object["addition"]! as! String
            let lat = object["place"]!!.latitude as Double
            let long = object["place"]!!.longitude as Double
            let type = object["type"]! as! String
            let locationId = object.objectId!! as String
            let date = object.createdAt!! as NSDate
            let street = object["street"]! as! String
            let zip = object["zip"]! as! String
            let city = object["city"]! as! String
            
            let loc = Location(latitude: lat, longitude: long, descr: addition, category: type, id: locationId, date:date, street:street, zip:zip, city:city)
            list.append(loc)
            
        }
    }
    
    public func getItemAtIndex(index:Int) -> Location {
        return list[index]
    }
    

    
    
    
}


