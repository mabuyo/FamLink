//
//  LocationDetailViewController.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-15.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import UIKit
import MapKit

class LocationDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var selectedLocation: Location!
    let regionRadius = 100.0
    
    // UI
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationMapView: MKMapView!
    @IBOutlet weak var locationEditButton: UIButton!
    
    // Navigation items
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var navBarDoneButton: UIBarButtonItem!
    
    // Map
    let locationManager = CLLocationManager()

    // MARK - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup locationManager
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // setup mapView
        locationMapView.delegate = self
        locationMapView.showsUserLocation = true
        locationMapView.userTrackingMode = .follow


        // update UI
        locationNameLabel.text = selectedLocation.name
        iconView.image = selectedLocation.icon
        navBarTitle.title = "Edit your " + selectedLocation.name + " location"
        

        // display location on map (if coordinates provided)
        if let coords = selectedLocation.coordinates {
            
            centerMapOnLocation(location: coords)
            
            // place pin
            let annotation = MKPointAnnotation()
            annotation.coordinate = coords.coordinate
            annotation.title = "\(selectedLocation.name)"
            locationMapView.addAnnotation(annotation)
            
            // draw circle for region
            let circle = MKCircle(center: coords.coordinate, radius: regionRadius)
            locationMapView.add(circle)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     
     
    }
    */
    
    // MARK: Exit methods
    @IBAction func doneButtonClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {});
    }
    
    
    // MARK: MapView functions
    func centerMapOnLocation(location: CLLocation) {
        let centerRegion = 1000.0
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  centerRegion * 2.0, centerRegion * 2.0)
        locationMapView.setRegion(coordinateRegion, animated: true)
    }
    
    // 6. draw circle
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.blue
            circle.fillColor = UIColor(red: 0, green: 0, blue: 255, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return MKPolylineRenderer()
        }
    }
    

}
