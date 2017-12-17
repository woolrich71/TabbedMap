//
//  Position.swift
//  TabbedMap
//
//  Created by Ulrik Nilsson on 2017-12-12.
//  Copyright © 2017 Ulrik Nilsson. All rights reserved.
//
import Foundation

struct Position: Codable {
    var lat: Float
    var lng: Float
    
    init(lat: Float, lng: Float) {
        self.lat = lat
        self.lng = lng
    }
    
}
