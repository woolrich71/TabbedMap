//
//  SecondViewController.swift
//  TabbedMap
//
//  Created by Ulrik Nilsson on 2017-12-11.
//  Copyright © 2017 Ulrik Nilsson. All rights reserved.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController,  LocationServiceDelegate {

    var currentLocation: CLLocation?
    
    var restController = RestController()
    
    
    
    
    
    
    @IBOutlet weak var textArea: UITextView!
    
    var displayText: String {
        get {
            return textArea.text!
        }
        set {
            textArea.text = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var user: User?
        if let lat = UserDefaults.standard.float(forKey: "lat") as? Float,
            let lng = UserDefaults.standard.float(forKey: "lng") as? Float {
            let uuid = UIDevice.current.identifierForVendor!.uuidString
            user = User(id: nil, uuid: uuid, destination: Position(lat: lat, lng: lng ), address: nil)
        }
        
        restController.post(user!) { (user : User?) in
            if let user = user {
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .prettyPrinted
                do {
                    let jsonData = try jsonEncoder.encode(user)
                    let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
                    DispatchQueue.main.async {
                        //perform all UI stuff here
                        guard let b = jsonString else {
                            self.displayText = "noo..."
                            return
                        }
                        print(b)
                        self.displayText = b
                        
                    }
                    
                    
                    print("JSON String : " + jsonString!)
                }
                catch {
                }
            }
        }
        
        
        LocationService.sharedInstance.startUpdatingLocation()
        LocationService.sharedInstance.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    var earlierDate =  Date()
    var previousLocation: CLLocation?
    
    func tracingLocation(currentLocation: CLLocation) {
       
        let now = Date()
        if previousLocation != nil {
            let distance = previousLocation!.distance(from: currentLocation)
            if(distance < 100) {
                let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
                let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: earlierDate, to: now );
                if let min = difference.minute {
                    if (min > 0) {
                        earlierDate = now
                    }
                    else {
                        return
                    }
                }
            } else {
                previousLocation = currentLocation
                
            }
        }  else {
            previousLocation = currentLocation
        }
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        let ping = Ping( uuid: uuid, position:
            Position(lat: Float(currentLocation.coordinate.latitude), lng: Float(currentLocation.coordinate.longitude)))
        
        restController.post(ping) { (result : Result?) in
            if let result = result {
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .prettyPrinted
                do {
                    let jsonData = try jsonEncoder.encode(result)
                    let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
                    DispatchQueue.main.async {
                        //perform all UI stuff here
                        guard let b = jsonString else {
                            self.displayText = "noo..."
                            return
                        }
                        print(b)
                        self.displayText = b
                        
                    }
                    
                    
                    print("JSON String : " + jsonString!)
                }
                catch {
                }
            }
        }
        
        print(currentLocation)
        
        
        
        
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        print(error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
   
}

