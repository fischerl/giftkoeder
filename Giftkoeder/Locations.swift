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
        print(objects)
        for object in objects!
        {
            //                        print(object)
            //                        print(object["addition"]! as! String)
            //                        print(object["place"]!!.latitude as Double)
            //                        print(object["place"]!!.longitude as Double)
            //                        print(object["type"]! as! String)
            
            let addition = object["addition"]! as! String
            let lat = object["place"]!!.latitude as Double
            let long = object["place"]!!.longitude as Double
            let type = object["type"]! as! String
            let locationId = object.objectId!! as String
            let date = object.createdAt!! as NSDate
            
            
            let loc = Location(latitude: lat, longitude: long, descr: addition, category: type, id: locationId, date:date)
            list.append(loc)
            
        }
        
        print("Locations:")
        print(list.count)
    }
    
    public func updateLocations()
    {
        list = [Location]()
        let query = PFQuery(className:"Warnings")
        var objects = query.findObjects()
        for object in objects!
        {
            //                        print(object)
            //                        print(object["addition"]! as! String)
            //                        print(object["place"]!!.latitude as Double)
            //                        print(object["place"]!!.longitude as Double)
            //                        print(object["type"]! as! String)
            
            let addition = object["addition"]! as! String
            let lat = object["place"]!!.latitude as Double
            let long = object["place"]!!.longitude as Double
            let type = object["type"]! as! String
            let locationId = object.objectId!! as String
            let date = object.createdAt!! as NSDate
            
            
            let loc = Location(latitude: lat, longitude: long, descr: addition, category: type, id: locationId, date:date)
            list.append(loc)
            
        }
        print("Locations Update:")
        print(list.count)
        for item in list
        {
            print(item.latitude)
            print(item.longitude)
            print("---------------")
        }
    }
    
    public func getItemAtIndex(index:Int) -> Location {
        return list[index]
    }
    

    
    
    
}


