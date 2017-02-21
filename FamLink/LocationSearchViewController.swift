//
//  LocationSearchViewController.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-15.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var radiusButton: UIBarButtonItem!
    private var radiusLabel = UILabel(frame: CGRect.zero)
    
    @IBOutlet weak var mapView: MKMapView!
    var locationEditing: Location!
    var chosenPlacemark: MKPlacemark!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // Search
    var resultSearchController:UISearchController? = nil
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gestureRecognizer.delegate = self
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(LocationSearchViewController.handleTap(recognizer:)))
//        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)

        
        // UI
        saveButton.isEnabled = false
        
        // Dummy button
        radiusLabel.text = "Radius"
        radiusLabel.sizeToFit()
        radiusLabel.backgroundColor = UIColor.clear
        radiusLabel.textAlignment = .center
        radiusLabel.textColor = UIColor.black
        radiusButton.tintColor = UIColor.black
        radiusButton.customView = radiusLabel
        
        // set up location search results table
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchResultsTable") as! LocationSearchResultsTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        locationSearchTable.mapView = mapView

        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        // search results clicked
        locationSearchTable.handleMapSearchDelegate = self
        
        mapView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleTap(recognizer: UILongPressGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizerState.ended) {
            print("map tapped!!!!")
            
            let location = recognizer.location(in: mapView)
            let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
            
            // clear existing pins
            mapView.removeAnnotations(mapView.annotations)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = locationEditing.name
            mapView.addAnnotation(annotation)
            
            // draw circle for region
            mapView.removeOverlays(mapView.overlays)
            let circle = MKCircle(center: coordinate, radius: 100.0)
            mapView.add(circle)
            
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegionMake(coordinate, span)
            mapView.setRegion(region, animated: true)
            
            

        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
 
    
    @IBAction func cancelButtonClicked() {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: handle map search
protocol HandleMapSearch: class {
    func dropPinZoomIn(placemark:MKPlacemark)
}

extension LocationSearchViewController: HandleMapSearch {
    // Called when search result is clicked
    func dropPinZoomIn(placemark: MKPlacemark) {
        // save the placemark
        chosenPlacemark = placemark
        
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = getAnnotation(placemark: placemark)
        mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
        
        saveButton.isEnabled = true
        
    }

}

// MARK: MapViewDelegate
extension LocationSearchViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.blue
        pinView?.canShowCallout = true
        pinView?.isDraggable = true
        
        // draw icon
        let image = locationEditing.icon
        let icon = UIButton(type: .custom)
        icon.frame = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 30, height: 30))
        icon.setImage(image, for: .normal)
        pinView?.leftCalloutAccessoryView = icon
        
        return pinView
    }
    
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        
        if newState == MKAnnotationViewDragState.ending {
            let _ = view.annotation?.coordinate
            // draw circle for region
            mapView.removeOverlays(mapView.overlays)
            let circle = MKCircle(center: (view.annotation?.coordinate)!, radius: 100.0)
            mapView.add(circle)
        }
    }
}
