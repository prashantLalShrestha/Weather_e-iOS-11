//
//  Extensions.swift
//  Weather_e
//
//  Created by ram on 12/5/17.
//  Copyright © 2017 ram. All rights reserved.
//

import Foundation

extension Date {
    var stringDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        let date = "\(currentDate)"
        return date
    }
    
    var dayOfTheWeek: String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE"
        return dateformatter.string(from: self)
    }
}

extension Double {
    var kelvinToFarenheit: Double {
        let kelvinToFarenheitPreDivision = (self * (9/5) - 459.67)
        let kelvinToFarenheit = Double(Darwin.round(10 * kelvinToFarenheitPreDivision/10))
        return kelvinToFarenheit
    }
    
    var unixConvertedDate: Date {
        let unixConvertedDate = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeStyle = .none
        return unixConvertedDate
    }
}
