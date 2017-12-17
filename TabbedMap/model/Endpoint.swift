//
//  WithUrl.swift
//  TabbedMap
//
//  Created by Ulrik Nilsson on 2017-12-13.
//  Copyright © 2017 Ulrik Nilsson. All rights reserved.
//

import Foundation

protocol Endpoint {
    static func endpoint(url: String) -> String
}
