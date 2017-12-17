//
//  Ping.swift
//  TabbedMap
//
//  Created by Ulrik Nilsson on 2017-12-12.
//  Copyright © 2017 Ulrik Nilsson. All rights reserved.
//

import Foundation

struct Ping: Codable, Endpoint {
    
    
    let uuid: String
    let position: Position
    let timeStamp = Date()
    
    init( uuid: String, position: Position ) {
        self.uuid = uuid
        self.position = position
    }
    
    // MARK: URLs
    static func endpoint(url: String) -> String {
        let endpoint = url  + "/ping"
        return endpoint
    }
}
