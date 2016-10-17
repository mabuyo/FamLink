//
//  LocationSearchViewController.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-15.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var locationEditing: Location!
    var chosenPlacemark: MKPlacemark!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // Search
    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        saveButton.isEnabled = false
        
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "saveLocation" {
            print("Saving!!")
        }
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
        
        // draw icon
        let image = locationEditing.icon
        let icon = UIButton(type: .custom)
        icon.frame = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 30, height: 30))
        icon.setImage(image, for: .normal)
        pinView?.leftCalloutAccessoryView = icon
        
        return pinView
    }
}
