//
//  AppDelegate.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-09.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import GoogleSignIn
import UserNotifications
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    let locationManager = CLLocationManager()
//    var mainUser = User(name: "Michelle", color: "green", current_location: nil)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self])
        
        // MARK: location manager setup
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
        
        FIRApp.configure()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
    
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: [:])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("test")
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }


    // MARK: - Core Data stack

    var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "FamJamClock")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 //TODO finish app
                 // create if
                 // put else
                 // 
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



extension AppDelegate: CLLocationManagerDelegate {
    func handleEvent(forRegion region: CLRegion!, forEvent event: String!) {
        // If application is active
        if UIApplication.shared.applicationState == .active {
            print("Did \(event) region with identifier \(region.identifier) and named \(findLocation(forIdentifier: region.identifier).name)")
            
            let location_name = findLocation(forIdentifier: region.identifier).name
            
            if (event == "ENTER"){
                FamLinkClock.sharedInstance.updateLocation(location_name)
                let content = UNMutableNotificationContent()
                content.title = "Meeting Reminder"
                content.subtitle = "test"
                content.body = "Don't forget to bring coffee."
                content.badge = 1
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
                                                                repeats: false)
                
                let requestIdentifier = UUID().uuidString
                let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, 
                                                       withCompletionHandler: { (error) in
                                                        // Handle error
                })
            } else {
                FamLinkClock.sharedInstance.updateLocation("last-" + location_name)
            }
            
        } else {
            // Otherwise present a local notification
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            handleEvent(forRegion: region, forEvent: "ENTER")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            handleEvent(forRegion: region, forEvent: "EXIT")
        }
    }
    
    /*
     * findLocation with identifier returns the location with that associated identifier
     */
    func findLocation(forIdentifier identifier: String) -> Location {
        for location in LocationsDataSource().locations {
            if location.identifier == identifier {
                return location
            }
        }
        
        // TODO: learn about errors and how to raise errors
        return Location(name: "error", icon: UIImage(named: "bug")!, number: 13, placemark: nil, identifier: nil)
    }
}

