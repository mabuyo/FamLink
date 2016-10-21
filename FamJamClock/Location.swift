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

class Location: NSObject, NSCoding {
    
    // MARK: properties
    var name: String
    var icon: UIImage
    var number: Int
    var placemark: MKPlacemark?
    
    // MARK: types
    struct PropertyKey {
        static let nameKey = "name"
        static let iconKey = "icon"
        static let numberKey = "number"
        static let placemarkKey = "placemark"
    }
    
    // MARK: init
    init(name: String, icon: UIImage, number: Int, placemark: MKPlacemark?) {
        self.name = name
        self.icon = icon
        self.number = number
        self.placemark = placemark
        
    }
    
    // MARK: archiving paths
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    static let archiveURL = documentsDirectory.appendingPathComponent("locations")


    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(icon, forKey: PropertyKey.iconKey)
        aCoder.encode(number, forKey: PropertyKey.numberKey)
        aCoder.encode(placemark, forKey: PropertyKey.placemarkKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let icon = aDecoder.decodeObject(forKey: PropertyKey.iconKey) as! UIImage
        let number = aDecoder.decodeInteger(forKey: PropertyKey.numberKey) as! Int
        let placemark = aDecoder.decodeObject(forKey: PropertyKey.placemarkKey) as? MKPlacemark
        
        self.init(name: name, icon: icon, number: number, placemark: placemark)
    }
}
