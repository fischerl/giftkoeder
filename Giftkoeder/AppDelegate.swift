//
//  AppDelegate.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 15.06.15.
//  Copyright (c) 2015 TeamGK. All rights reserved.
//

import UIKit
import Parse
import GoogleMaps



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
 
        // Parse
        Parse.enableLocalDatastore()
        Parse.setApplicationId("UQoNQ5lfQ4qJ57ky7MGFpjJc1LpgJeLnOKCRce5b",
            clientKey: "dawBGOtkcLk57ETJ8kdLSrbwp0gUcOLpTXIYoVd8")
        
        // Google Maps
        GMSServices.provideAPIKey("AIzaSyBXbzaF43g7eXL4qAUU4KDDfje3Talcl9Y")
        
        return true
    }

    func applicationWillResignActive(application: UIApplication)
    {

    }

    func applicationDidEnterBackground(application: UIApplication)
    {

    }

    func applicationWillEnterForeground(application: UIApplication)
    {

    }

    func applicationDidBecomeActive(application: UIApplication)
    {

    }

    func applicationWillTerminate(application: UIApplication)
    {

    }


}

