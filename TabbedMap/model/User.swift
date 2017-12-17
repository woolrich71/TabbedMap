//
//  User.swift
//  TabbedMap
//
//  Created by Ulrik Nilsson on 2017-12-12.
//  Copyright © 2017 Ulrik Nilsson. All rights reserved.
//

import Foundation


struct User: Codable, Endpoint {
    let id: String?
    let uuid: String?
    let destination: Position?
    let address: String?
    
    init(id: String?,  uuid: String, destination: Position, address: String? ) {
        self.id=id
        self.uuid = uuid
        self.destination = destination
        self.address = address
    }
    
    // MARK: URLs
    static func endpoint(url: String) -> String {
        let endpoint = url  + "/login"
        return endpoint
    }
}
