//
//  LocationDetailViewController.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-15.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import UIKit
import MapKit
import QuartzCore

class LocationDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var selectedLocation: Location!
    let regionRadius = 100.0
    
    @IBOutlet weak var detailCard: UIView!
    @IBOutlet weak var iconContainer: UIView!
    
    // UI
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    @IBOutlet weak var locationMapView: MKMapView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // Map
    let locationManager = CLLocationManager()

    // MARK - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailCard.layer.cornerRadius = 25
        self.detailCard.layer.masksToBounds = true
        
        self.iconContainer.layer.cornerRadius = self.iconContainer.frame.size.width/2
        self.iconContainer.layer.masksToBounds = true
        
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
        locationAddressLabel.text = "No address has been set."
        if (selectedLocation.placemark) != nil {
            deleteButton.isEnabled = true
        } else {
            deleteButton.isEnabled = false
        }

        // display location on map (if coordinates provided)
        if let placemark = selectedLocation.placemark {
            let lat = placemark.coordinate.latitude
            let long = placemark.coordinate.longitude
            
            centerMapOnLocation(location: CLLocation(latitude: lat, longitude: long), mapView: locationMapView)
            
            
            // place pin
            let annotation = getAnnotation(placemark: placemark)
            locationMapView.addAnnotation(annotation)
            
            // draw circle for region
            let circle = MKCircle(center: placemark.coordinate, radius: regionRadius)
            locationMapView.add(circle)
            
            locationAddressLabel.text = parseAddress(selectedItem: placemark)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewCo
        if segue.identifier == "showLocationSearch" {
            let searchVC: LocationSearchViewController = segue.destination.childViewControllers[0] as! LocationSearchViewController
                searchVC.locationEditing = selectedLocation
        }
     
    }
    
    
    // MARK: Exit methods
    @IBAction func doneButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {})
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        selectedLocation.placemark = nil
        self.dismiss(animated: true, completion: {})
    }
    
    
    // MARK: MapView functions
//    func centerMapOnLocation(location: CLLocation) {
//        let centerRegion = 1000.0
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, centerRegion * 2.0, centerRegion * 2.0)
//        locationMapView.setRegion(coordinateRegion, animated: true)
//    }
    
    // draw circle
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
    
    // TODO: [REFACTOR] this code is in 2 places: LocationDetailViewController and LocationSearchViewController.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "detailPin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.blue
        pinView?.canShowCallout = true
        
        // draw icon
        let image = selectedLocation.icon
        let icon = UIButton(type: .custom)
        icon.frame = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 30, height: 30))
        icon.setImage(image, for: .normal)
        pinView?.leftCalloutAccessoryView = icon
        
        return pinView
    }
    

}
