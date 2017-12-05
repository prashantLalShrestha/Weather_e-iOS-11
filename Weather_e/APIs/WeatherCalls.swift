//
//  WeatherCalls.swift
//  Weather_e
//
//  Created by ram on 12/5/17.
//  Copyright © 2017 ram. All rights reserved.
//

import UIKit
import Alamofire

class WeatherCall {
    private var cityname: String? = ""
    private var date: String? = ""
    private var weatherType: String? = ""
    private var currentTemperature: Double? = 0.0
    
    private var forcastDate: String? = ""
    private var forcastWeatherType: String? = ""
    private var highTemperature: Double? = 0.0
    private var lowTemperature: Double? = 0.0
    
    private var forcastData: [Forcast]? = []
    
    func downloadCurrentWeatherDetails(completed: @escaping DownloadComplete) {
        let currentWeatherUrl = URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(currentWeatherUrl!).responseJSON { (response) in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>  {
                
                if let date = dict["dt"] as? Double {
                    self.date = "Today \(date.unixConvertedDate.stringDate)"
                }
                if let name = dict["name"] as? String {
                    self.cityname = name
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self.weatherType = main.capitalized
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        self.currentTemperature = currentTemperature.kelvinToFarenheit
                    }
                }
            }
            completed()
        }
    }
    
    func downloadForcastData(completed: @escaping DownloadComplete) {
        let forcastUrl = URL(string: FORCAST_URL)
        Alamofire.request(forcastUrl!).responseJSON { (response) in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        if let temp = obj["temp"] as? Dictionary<String, AnyObject> {
                            if let min = temp["min"] as? Double, let max = temp["max"] as? Double {
                                self.lowTemperature = min.kelvinToFarenheit
                                self.highTemperature = max.kelvinToFarenheit
                            }
                        }
                        
                        if let weather = obj["weather"] as? [Dictionary<String, AnyObject>] {
                            if let main = weather[0]["main"] as? String {
                                self.forcastWeatherType = main.capitalized
                            }
                        }
                        
                        if let date = obj["dt"] as? Double {
                            self.forcastDate = date.unixConvertedDate.dayOfTheWeek
                        }
                        self.forcastData?.append(self.getForcastWeather())
                    }
                }
            }
            completed()
        }
    }
}

extension WeatherCall {
    func getCurrentWeather() -> CurrentWeather {
        return CurrentWeather(
            cityName: cityname ?? "",
            date: date ?? "",
            weatherType: weatherType ?? "",
            currentTemperature: currentTemperature ?? 0.0
        )
    }
    
    func  getForcastWeather() -> Forcast {
        return Forcast(
            date: forcastDate ?? "",
            weatherType: forcastWeatherType ?? "",
            highTemperature: highTemperature ?? 0.0,
            lowTemperature: lowTemperature ?? 0.0
        )
    }
    
    func getForcastWeatherData() -> [Forcast] {
        return forcastData ?? []
    }
}



