//
//  LocationsDataSource.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-15.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import Foundation

class LocationsDataSource {
    
    init() {
        populateData()
    }
    
    var locations: [Location] = []
    
    // MARK: populateData from plist
    func populateData() {
        // TODO: Load this data from persistent storage on phone, eventually going to be data grabbed from the Photon (for future expandable icon feature)
        // For now, just have static icons
        let home = Location(name: "home", icon: "home.jpg", number: 12)
        let concert = Location(name: "concert", icon: "music.jpg", number: 1)
        let work = Location(name: "work", icon: "briefcase.jpg", number: 2)
        let coffee = Location(name: "coffee", icon: "coffee-cup.jpg", number: 3)
        let school = Location(name: "school", icon: "book.jpg", number: 4)
        let bar = Location(name: "bar", icon: "cocktail-glass.jpg", number: 5)
        let restaurant = Location(name: "restaurant", icon: "fork-and-knife.jpg", number: 6)
        let hospital = Location(name: "hospital", icon: "hospital.jpg", number: 7)
        let airport = Location(name: "airport", icon: "plane.jpg", number: 8)
        let transit = Location(name: "transit", icon:"truck.jpg", number: 9)
        let lab = Location(name: "lab", icon: "beaker.jpg", number: 10)
        let bug = Location(name: "bug", icon: "bug.jpg", number: 11)

        locations = [home, concert, work, coffee, school, bar, restaurant, hospital, airport, transit, lab, bug]
    }
    
}
