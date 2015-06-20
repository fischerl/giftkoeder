//
//  Location.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 19.06.15.
//  Copyright © 2015 TeamGK. All rights reserved.
//

import Foundation


class Location {
    var latitude: Double
    var longitude: Double
    
    var descr: String
    var category: String
    
    var id:String
    var date:NSDate
    
    init(latitude:Double, longitude:Double, descr:String, category:String, id:String, date:NSDate)
    {
        self.latitude = latitude
        self.longitude = longitude
        self.descr = descr
        self.category = category
        self.id = id
        self.date = date
    }
}
