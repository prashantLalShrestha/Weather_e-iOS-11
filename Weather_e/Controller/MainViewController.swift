//
//  ViewController.swift
//  Weather_e
//
//  Created by ram on 12/5/17.
//  Copyright © 2017 ram. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var weatherView: WeatherView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var forcastData: [Forcast]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationInit()
        tableViewInit()
    }
    
    func tableViewInit() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let tableViewCell = UINib(nibName: "ForcastTableViewCell", bundle: nil)
        tableView.register(tableViewCell, forCellReuseIdentifier: "forcastTableViewCell")
    }
    
    func locationInit() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            guard let currentLocation = locationManager.location else {
                locationAuthStatus()
                return
            }
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            let weatherCall = WeatherCall()
            weatherCall.downloadCurrentWeatherDetails(completed: {
                let currentWeather: CurrentWeather? = weatherCall.getCurrentWeather()
                self.weatherView.viewModel = WeatherView.ViewModel(currentWeather: currentWeather!)
                weatherCall.downloadForcastData(completed: {
                    self.forcastData = weatherCall.getForcastWeatherData()
                    self.forcastData?.remove(at: 0)
                    self.tableView.reloadData()
                })
            })
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let forcasts = forcastData else {
            return 0
        }
        return forcasts.count - 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forcastTableViewCell", for: indexPath) as? ForcastTableViewCell
        cell?.viewModel = ForcastTableViewCell.ViewModel(forcast: self.forcastData![indexPath.row])
        return cell!
    }
}

