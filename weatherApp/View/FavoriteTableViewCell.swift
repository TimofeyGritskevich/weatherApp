//
//  FavoriteTableViewCell.swift
//  weatherApp
//
//  Created by TimoXaq on 24/04/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var citynameLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var weatherInfoView: UIView!
    
    func loadWith(weather: Weather) {
        weatherInfoView.layer.cornerRadius = 16
        weatherInfoView.clipsToBounds = true
        
        let imagename = Manager.setWeatherImage(condition: weather.condition!, sunsetTime: weather.sunset, sunriseTime: weather.sunrise)
        DispatchQueue.main.async {
            self.weatherConditionImage.image = UIImage(named: imagename)
            self.weatherInfoView.backgroundColor = UIColor(cgColor: Manager.timeFirstColorArray[imagename]!)
        }

        citynameLabel.text = weather.name
        tempLabel.text = weather.temp
        weatherConditionLabel.text = weather.condition
        cloudsLabel.text = weather.clouds
        humidityLabel.text = weather.humidity
        windLabel.text = weather.windSpeed
    }
}

