//
//  FirstViewController.swift
//  TabbedMap
//
//  Created by Ulrik Nilsson on 2017-12-11.
//  Copyright © 2017 Ulrik Nilsson. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var map: MKMapView!
    
    @IBAction func handleLongTap(gestureReconizer: UILongPressGestureRecognizer) {
        if let mapView = self.view.viewWithTag(999) as? MKMapView { // set tag in IB
            // remove current annons except user location
            let annotationsToRemove = mapView.annotations.filter
            { $0 !== mapView.userLocation }
            mapView.removeAnnotations( annotationsToRemove )
            
            // add new annon
            let location = gestureReconizer.location(in: mapView)
            let coordinate = mapView.convert(location,
                                             toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerSettingsBundle()
        NotificationCenter.default.addObserver(self, selector: #selector(FirstViewController.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        defaultsChanged()
        
    }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    
    @objc func defaultsChanged(){
        
        if let lat = UserDefaults.standard.double(forKey: "lat") as? Double, let lng = UserDefaults.standard.double(forKey: "lng") as? Double {
            let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = ""
            map.addAnnotation(annotation)
        }
    }
    
    deinit { //Not needed for iOS9 and above. ARC deals with the observer in higher versions.
        NotificationCenter.default.removeObserver(self)
    }
    
}

