//
//  AppDelegate.swift
//  Encouragement App
//
//  Created by Weber, Nancy L on 3/26/18.
//  Copyright © 2018 Weber, Nancy L. All rights reserved.
//

import UIKit


/*
per documentation:
Apply the UIApplicationMain attribute to a class to indicate that it’s the application delegate.  (Syntax is @UIApplicationMain.) Using this attribute is equivalent to calling the UIApplicationMain function and passing this class’s name as the name of the delegate class. 
*/

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // initializing messages variable as an instance of the MessageDatabase class
    // variable is then updated in the application() function with a call to the initializeMessages() function
    var messages: MessageDatabase = MessageDatabase()
    
    // initializing alerts variable as an instance of the AlertMessageDatabase class
    // variables within the class have initial default values
    var alerts = AlertMessageDatabase()
	
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
						
		// updating the messages variable
        // upon first launch, the messages.initializeMessages() function is called to initialize messages.allMessages
        // every launch thereafter, however, should instead initialize messages.allMessages by accessing data from persistent storage via the messages.init() function
		// note that since the messages variable is an instance of the MessageDatabase class, it has access to MessageDatabase functions
       if messages.allMessages == []{
            messages.initializeMessages()
        }
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        // exporting data to persistent storage when application exits
        messages.exportMessages()

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
        // exporting data to persistent storage when application exits
        messages.exportMessages()
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        // exporting data to persistent storage when application exits
        messages.exportMessages()
       
        
    }
    
    


}

