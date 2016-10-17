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
        // TODO: Load this data from persistent storage on phone, eventually going to be data grabbed from the Photon (for future expandable icon feature)
        // For now, just have static icons
        let home = Location(name: "home", icon: UIImage(named: "home")!, number: 12)
        let concert = Location(name: "concert", icon: UIImage(named: "music")!, number: 1)
        let work = Location(name: "work", icon: UIImage(named: "briefcase")!, number: 2)
        let coffee = Location(name: "coffee", icon: UIImage(named: "coffee-cup")!, number: 3)
        let school = Location(name: "school", icon: UIImage(named: "book")!, number: 4)
        let bar = Location(name: "bar", icon: UIImage(named: "cocktail-glass")!, number: 5)
        let restaurant = Location(name: "restaurant", icon: UIImage(named: "fork-and-knife")!, number: 6)
        let hospital = Location(name: "hospital", icon: UIImage(named: "hospital")!, number: 7)
        let airport = Location(name: "airport", icon: UIImage(named: "plane")!, number: 8)
        let transit = Location(name: "transit", icon: UIImage(named: "truck")!, number: 9)
        let lab = Location(name: "lab", icon: UIImage(named: "beaker")!, number: 10)
        let bug = Location(name: "bug", icon: UIImage(named: "bug")!, number: 11)
        
        home.placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 53.485179, longitude: -113.504746))

        locations = [home, concert, work, coffee, school, bar, restaurant, hospital, airport, transit, lab, bug]
    }
    
}
