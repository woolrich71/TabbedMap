//
//  Section.swift
//  TabbedMap
//
//  Created by Ulrik Nilsson on 2017-12-12.
//  Copyright © 2017 Ulrik Nilsson. All rights reserved.
//

import Foundation


struct Section: Codable {

    let id: String?
    let time: String?
    let start : String? //LocalTime
    let stop: String? // LocalTime
    let type: String? // LocalTime
    let name: String? // LocalTime
    let from: String? // LocalTime
    let to: String? // LocalTime
    
}
