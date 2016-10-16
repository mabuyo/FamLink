//
//  Location.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-15.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Location {
    var name: String
    var icon: UIImage
    var coordinates: CLLocation?
    var number: Int
    
    init(name: String, icon: UIImage, number: Int) {
        self.name = name
        self.icon = icon
        self.number = number
    }
}
