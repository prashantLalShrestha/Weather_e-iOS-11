//
//  Constants.swift
//  Weather_e
//
//  Created by ram on 12/5/17.
//  Copyright © 2017 ram. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let appId = ""

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=\(appId)"
let FORCAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&appid=\(appId)"
