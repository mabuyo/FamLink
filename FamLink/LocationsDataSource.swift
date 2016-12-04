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
        populateData()
    }
    
    var locations: [Location] = []
    
    // MARK: populateData from plist
    func populateData() {
        if let locationsLoading = (NSKeyedUnarchiver.unarchiveObject(withFile: Location.archiveURL.path) as? [Location]) {
            locations = locationsLoading
        } else {
            // TODO: Grab locations from Photon
            let home = Location(name: "home", icon: UIImage(named: "home")!, number: 12, placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 53.485179, longitude: -113.504746)))
            let concert = Location(name: "concert", icon: UIImage(named: "music")!, number: 1, placemark: nil)
            let work = Location(name: "work", icon: UIImage(named: "briefcase")!, number: 2, placemark: nil)
            let coffee = Location(name: "coffee", icon: UIImage(named: "coffee-cup")!, number: 3, placemark: nil)
            let school = Location(name: "school", icon: UIImage(named: "book")!, number: 4, placemark: nil)
            let bar = Location(name: "bar", icon: UIImage(named: "cocktail-glass")!, number: 5, placemark: nil)
            let restaurant = Location(name: "restaurant", icon: UIImage(named: "fork-and-knife")!, number: 6, placemark: nil)
            let hospital = Location(name: "hospital", icon: UIImage(named: "hospital")!, number: 7, placemark: nil)
            let airport = Location(name: "airport", icon: UIImage(named: "plane")!, number: 8, placemark: nil)
            let transit = Location(name: "transit", icon: UIImage(named: "truck")!, number: 9, placemark: nil)
            let lab = Location(name: "lab", icon: UIImage(named: "beaker")!, number: 10, placemark: nil)
            let bug = Location(name: "bug", icon: UIImage(named: "bug")!, number: 11, placemark: nil)
            
            locations = [home, concert, work, coffee, school, bar, restaurant, hospital, airport, transit, lab, bug]
        }
    }
    
}
