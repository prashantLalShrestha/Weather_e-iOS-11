//
//  WeatherView.swift
//  Weather_e
//
//  Created by ram on 12/5/17.
//  Copyright © 2017 ram. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!

    var viewModel: ViewModel = ViewModel() {
        didSet {
            dateLabel.text = viewModel.date
            currentTemperatureLabel.text = viewModel.currentTemperature
            locationLabel.text = viewModel.location
            currentWeatherImage.image = UIImage(named: viewModel.currentWeatherImage)
            currentWeatherTypeLabel.text = viewModel.currentWeatherType
        }
    }
}

extension WeatherView {
    struct ViewModel {
        let date: String
        let currentTemperature: String
        let location: String
        let currentWeatherType: String
        let currentWeatherImage: String
    }
}

extension WeatherView.ViewModel {
    init(currentWeather: CurrentWeather) {
        date = currentWeather.date
        currentTemperature = "\(currentWeather.currentTemperature)°F"
        location = currentWeather.cityName
        currentWeatherType = currentWeather.weatherType
        currentWeatherImage = currentWeather.weatherType
    }
    
    init() {
        date = ""
        currentTemperature = ""
        location = ""
        currentWeatherImage = ""
        currentWeatherType = ""
    }
}
