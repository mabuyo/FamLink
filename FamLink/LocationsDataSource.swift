//
//  LocationsDataSource.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-15.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LocationsDataSource {
    
    init() {
        // FIXME: this gets called every time we access locations. fix this to happen only once (?)
        populateData()
    }
    
    var locations: [Location] = []
    
    // MARK: populateData from plist
    func populateData() {

        if let locationsLoading = (NSKeyedUnarchiver.unarchiveObject(withFile: Location.archiveURL.path) as? [Location]) {
            self.locations = locationsLoading
        } else {
            // TODO: Grab locations from Photon
            testSetToDefault()
       }
    }
    
    func testSetToDefault() {
        let home = Location(name: "home", icon: UIImage(named: "home")!, number: 12, placemark: nil, identifier: nil)
        let hospital = Location(name: "hospital", icon: UIImage(named: "hospital")!, number: 1, placemark: nil, identifier: nil)
        let school = Location(name: "school", icon: UIImage(named: "school")!, number: 2, placemark: nil, identifier: nil)
        let groceries = Location(name: "groceries", icon: UIImage(named: "groceries")!, number: 3, placemark: nil, identifier: nil)
        let restaurant = Location(name: "restaurant", icon: UIImage(named: "restaurant")!, number: 4, placemark: nil, identifier: nil)
        let bar = Location(name: "bar", icon: UIImage(named: "bar")!, number: 5, placemark: nil, identifier: nil)
        let work = Location(name: "work", icon: UIImage(named: "work")!, number: 6, placemark: nil, identifier: nil)
        let coffee = Location(name: "coffee", icon: UIImage(named: "coffee")!, number: 7, placemark: nil, identifier: nil)
        let house = Location(name: "house", icon: UIImage(named: "friend-house")!, number: 8, placemark: nil, identifier: nil)
        let gym = Location(name: "gym", icon: UIImage(named: "gym")!, number: 9, placemark: nil, identifier: nil)
        let airport = Location(name: "airport", icon: UIImage(named: "airport")!, number: 10, placemark: nil, identifier: nil)
        let sports = Location(name: "sports", icon: UIImage(named: "hockey")!, number: 11, placemark: nil, identifier: nil)

        
        self.locations = [home, hospital, school, groceries, restaurant, bar, work, coffee, house, gym, airport, sports]
        
        NSKeyedArchiver.archiveRootObject(self.locations, toFile: Location.archiveURL.path)
    }
    
}
