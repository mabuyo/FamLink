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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()
//    var mainUser = User(name: "Michelle", color: "green", current_location: nil)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // MARK: location manager setup
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        FIRApp.configure()
        
    
        return true
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

    lazy var persistentContainer: NSPersistentContainer = {
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
            let username = "michelle"
            
            let dataToSend = username + "," + location_name
            
            // send to Photon
            SparkCloud.sharedInstance().publishEvent(withName: "flink/user-loc-change", data: dataToSend, isPrivate: false, ttl: 60, completion: {(error: Error?) -> Void in
                if let e = error {
                    print("Error publishing event" + e.localizedDescription)
                } else {
                    print("Successfully published event")
                }
            })
            
            
            // color the correct circle on the clock!
            // find the clock number of the location
            let location = findLocation(forIdentifier: region.identifier)
//            mainUser.current_location = location
            
            if event == "ENTER" {
                
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

