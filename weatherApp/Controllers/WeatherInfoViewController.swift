//
//  WeatherInfoViewController.swift
//  weatherApp
//
//  Created by TimoXaq on 25/03/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit


class WeatherInfoViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windlabel: UILabel!
    @IBOutlet weak var visionLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet var mainView: UIView!
    
    let gradient = CAGradientLayer()

    var weather: Weather? {
        didSet {
            DispatchQueue.main.async {
                self.cityName.text = self.weather?.name
                self.weatherDescription.text = self.weather?.weatherDescription
                self.tempLabel.text = self.weather?.temp
                
                if let condition = self.weather?.condition,
                    let sunrise = self.weather?.sunrise,
                    let sunset = self.self.weather?.sunset,
                    let lon = self.weather?.longitude,
                    let lat = self.weather?.latitude,
                    let windDeg = self.weather?.windDeg,
                    let windSpeed = self.weather?.windSpeed {
                    self.self.sunriseLabel.text = Manager.setTimeFromUnix(unixTime: sunrise)
                    self.sunsetLabel.text = Manager.setTimeFromUnix(unixTime: sunset)
                    self.latLabel.text = String(lat)
                    self.lonLabel.text = String(lon)
                    
                    let weatherImageName = Manager.setWeatherImage(condition: condition, sunsetTime: sunset, sunriseTime: sunrise)
                    self.weatherImageView.image = UIImage(named: weatherImageName)
                    self.windlabel.text = Manager.setWindDirection(degree: windDeg) + " \(windSpeed)"
                    
                    if let firstColor = Manager.timeFirstColorArray[weatherImageName],
                        let secondColor = Manager.timeSecondColorArray[weatherImageName] {
                        self.mainView.layer.addSublayer(self.gradient)
                        Manager.globalColor = [firstColor, secondColor]
                        self.mainView.setGradient(gradient: self.gradient, colors: [firstColor, secondColor])
                        self.refreshButtonColor()
                    }
                }
                
                self.humidityLabel.text = self.weather?.humidity
                self.visionLabel.text = self.weather?.visibility
                self.cloudsLabel.text = self.weather?.clouds
            }
        }
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
    }

    func refreshButtonColor() {
        for button in buttonCollection {
            button.tintColor = UIColor(cgColor: Manager.globalColor[0])
        }
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        NetworkManager.getWeatherForActualPlace(latitude: Manager.actualLat, longitude: Manager.actualLon) { (weather) in
            weather.name = Manager.actualLocality
            self.weather = weather
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {

        if let controller = storyboard?.instantiateViewController(withIdentifier: "CityListViewController") as? CityListViewController {
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
        }      
    }
 
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
        let favoriteList = Manager.result.filter("favorite = %@", true)
        NetworkManager.getWeatherByGroup(list: favoriteList) { (weather) in

            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "FavoriteViewController") as? FavoriteViewController {
                controller.delegate = self
                controller.list = weather
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}

extension WeatherInfoViewController: CityListVCDelegate {
    func setNewWeather(newWeather: Weather) {
        self.weather = newWeather
    }
}

extension WeatherInfoViewController: FavoriteCVDelegate {
    func changeWeather(newWeather: Weather) {
        self.weather = newWeather
    } 
}
