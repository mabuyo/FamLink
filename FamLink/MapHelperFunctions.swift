//
//  MapHelperFunctions.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-16.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import Foundation
import MapKit

// Returns an annotation view for locations
func getAnnotation(placemark: MKPlacemark) -> MKPointAnnotation {
    let annotation = MKPointAnnotation()
    annotation.coordinate = placemark.coordinate
    annotation.title = placemark.name
    annotation.subtitle = parseAddress(selectedItem: placemark)
    
    return annotation
}


// Strings together a readable address
func parseAddress(selectedItem:MKPlacemark) -> String {
    // put a space between "4" and "Melrose Place"
    let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
    // put a comma between street and city/state
    let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
    // put a space between "Washington" and "DC"
    let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
    let addressLine = String(
        format:"%@%@%@%@%@%@%@",
        // street number
        selectedItem.subThoroughfare ?? "",
        firstSpace,
        // street name
        selectedItem.thoroughfare ?? "",
        comma,
        // city
        selectedItem.locality ?? "",
        secondSpace,
        // state
        selectedItem.administrativeArea ?? ""
    )
    return addressLine
}

func centerMapOnLocation(location: CLLocation, mapView: MKMapView) {
    let centerRegion = 200.0
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, centerRegion * 2.0, centerRegion * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
}
