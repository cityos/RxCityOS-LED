//
//  AppDelegate.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import RealmSwift
import LightFactory

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = UIColor.mainColor()
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : UIFont.mainFont(), NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont.mainFont(), NSForegroundColorAttributeName : UIColor.whiteColor()], forState: .Normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(red:0.52, green:0.82, blue:0.87, alpha:1)], forState: .Disabled)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.clearColor()], forState: UIControlState.Normal)
        UITabBar.appearance().backgroundColor =  UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
        UITabBar.appearance().tintColor = UIColor.mainColor()
        UITabBar.appearance().translucent = true
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().clipsToBounds = true
        
        UITabBar.appearance().backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        if let tabBarController = window?.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = 2
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

