//
//  LocationsCollectionViewController.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-13.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import UIKit
import CoreLocation

private let reuseIdentifier = "locationIconIdentifier"

class LocationsCollectionViewController: UICollectionViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var locations = LocationsDataSource().locations

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        addGradientBackground()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(LocationsIconCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.

    }

    func addGradientBackground() {
        let topColor = UIColor(red: (249/255.0), green: (207/255.0), blue: (81/255.0), alpha: 1)
        
        let bottomColor = UIColor(red: (250/255.0), green: (240/255.0), blue: (202/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.view.bounds
        
        self.collectionView?.backgroundView = UIView()
        self.collectionView?.backgroundView?.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
     
         assert(sender as? UICollectionViewCell != nil, "sender is not a collection view")
         
         if let indexPath = self.collectionView?.indexPath(for: sender as! UICollectionViewCell) {
             if segue.identifier == "showLocationDetail" {
                 let detailVC: LocationDetailViewController = segue.destination as! LocationDetailViewController
                 detailVC.selectedLocation = locations[indexPath.row]
             }
         } else {
             // Error sender is not a cell or cell is not in collectionView.
         }
    }
 
    // MARK: Segue from Location Search back to Collection View
    @IBAction func saveToLocationsCollectionView(segue: UIStoryboardSegue) {
        if let locationSearchVC = segue.source as? LocationSearchViewController {
            if let locationPlacemark = locationSearchVC.chosenPlacemark {
                
                // find the location in the Locations array
                if let location = locations.filter({$0.name == locationSearchVC.locationEditing.name}).first {
                    
                    // Stop monitoring the old region
                    if location.placemark != nil {
                        let oldRegion = getRegion(fromLocation: location)
                        locationManager.stopMonitoring(for: oldRegion)
                    }
                    
                    // update the location in the Locations array
                    location.placemark = locationPlacemark
                    location.identifier = NSUUID().uuidString
                    
                    // Start monitoring the new region
                    let region = getRegion(fromLocation: location)
                    locationManager.startMonitoring(for: region)
                    
                    
                    // save in persistent storage
                    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(locations, toFile: Location.archiveURL.path)
                    
                    if !isSuccessfulSave {
                        print("Failed to save locations.")
                    }
                }
                
            }
        }
    }
    
    // MARK: Segue from Delete button clicked
    @IBAction func deleteLocationFromLocations(segue: UIStoryboardSegue) {
        if let locationDetailVC = segue.source as? LocationDetailViewController {
            if let location = locationDetailVC.selectedLocation {
            
                // find the location in the Locations array
                if let location = locations.filter({$0.name == location.name}).first {
                    
                    // Stop monitoring the old region
                        let oldRegion = getRegion(fromLocation: location)
                        locationManager.stopMonitoring(for: oldRegion)
                    
                    // update the location in the Locations array
                    location.placemark = nil
                    location.identifier = nil
                    
                    
                    // save in persistent storage
                    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(locations, toFile: Location.archiveURL.path)
                    
                    if !isSuccessfulSave {
                        print("Failed to save locations.")
                    }
                }
                
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LocationsIconCollectionViewCell
    
        // Configure the cell
        let icon = locations[indexPath.row].icon
        cell.imageView.image = icon
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
fileprivate let itemsPerRow: CGFloat = 3


extension LocationsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: LocationManager
extension LocationsCollectionViewController {
    
    // Returns a CLCircularRegion from the placemark coordinates of a Location
    func getRegion(fromLocation: Location) -> CLCircularRegion {
        let fromPlacemark = fromLocation.placemark!
        let region = CLCircularRegion(center: fromPlacemark.coordinate, radius: 1000, identifier: fromLocation.identifier!)
        return region
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring failed for region with identifier: \(region!.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with the following error: \(error)")
    }
    
}
