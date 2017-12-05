//
//  ForcastTableViewCell.swift
//  Weather_e
//
//  Created by ram on 12/5/17.
//  Copyright © 2017 ram. All rights reserved.
//

import UIKit

class ForcastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemperature: UILabel!
    @IBOutlet weak var lowTemperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = [UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin]
        self.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var viewModel: ViewModel = ViewModel() {
        didSet {
            weatherIcon.image = UIImage(named: viewModel.weatherIcon)
            dayLabel.text = viewModel.day
            weatherType.text = viewModel.weatherType
            highTemperature.text = viewModel.highTemperature
            lowTemperature.text = viewModel.lowTemperature
        }
    }
}

extension ForcastTableViewCell {
    struct ViewModel {
        let weatherIcon: String
        let day: String
        let weatherType: String
        let highTemperature: String
        let lowTemperature: String
    }
}

extension ForcastTableViewCell.ViewModel {
    init(forcast: Forcast) {
        weatherIcon = forcast.weatherType
        day = forcast.date
        weatherType = forcast.weatherType
        highTemperature = "\(forcast.highTemperature)°F"
        lowTemperature = "\(forcast.lowTemperature)°F"
    }
    
    init() {
        weatherIcon = ""
        day = ""
        weatherType = ""
        highTemperature = ""
        lowTemperature = ""
    }
}
