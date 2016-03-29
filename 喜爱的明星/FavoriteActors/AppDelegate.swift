//
//  AppDelegate.swift
//  FavoriteActors
//
//  Created by Jason on 1/31/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Update TheMovieDB Config if it is older than seven days
        TheMovieDB.sharedInstance().config.updateIfDaysSinceUpdateExceeds(7)
        
        return true
    }
    
}

