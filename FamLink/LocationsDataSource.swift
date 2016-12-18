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
//            testSetToDefault()
            
        } else {
            // TODO: Grab locations from Photon
            testSetToDefault()
        }
    }
    
    func testSetToDefault() {
        let home = Location(name: "home", icon: UIImage(named: "home")!, number: 12, placemark: nil, identifier: nil)
        let concert = Location(name: "concert", icon: UIImage(named: "music")!, number: 1, placemark: nil, identifier: nil)
        let work = Location(name: "work", icon: UIImage(named: "briefcase")!, number: 2, placemark: nil, identifier: nil)
        let coffee = Location(name: "coffee", icon: UIImage(named: "coffee-cup")!, number: 3, placemark: nil, identifier: nil)
        let school = Location(name: "school", icon: UIImage(named: "book")!, number: 4, placemark: nil, identifier: nil)
        let bar = Location(name: "bar", icon: UIImage(named: "cocktail-glass")!, number: 5, placemark: nil, identifier: nil)
        let restaurant = Location(name: "restaurant", icon: UIImage(named: "fork-and-knife")!, number: 6, placemark: nil, identifier: nil)
        let hospital = Location(name: "hospital", icon: UIImage(named: "hospital")!, number: 7, placemark: nil, identifier: nil)
        let airport = Location(name: "airport", icon: UIImage(named: "plane")!, number: 8, placemark: nil, identifier: nil)
        let transit = Location(name: "transit", icon: UIImage(named: "truck")!, number: 9, placemark: nil, identifier: nil)
        let lab = Location(name: "lab", icon: UIImage(named: "beaker")!, number: 10, placemark: nil, identifier: nil)
        let bug = Location(name: "bug", icon: UIImage(named: "bug")!, number: 11, placemark: nil, identifier: nil)
        
        self.locations = [home, concert, work, coffee, school, bar, restaurant, hospital, airport, transit, lab, bug]
        
        NSKeyedArchiver.archiveRootObject(self.locations, toFile: Location.archiveURL.path)
    }
    
}
