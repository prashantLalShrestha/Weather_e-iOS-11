//
//  Location.swift
//  Weather_e
//
//  Created by ram on 12/5/17.
//  Copyright © 2017 ram. All rights reserved.
//

import Foundation

struct Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double? = 0.0
    var longitude: Double? = 0.0
}
