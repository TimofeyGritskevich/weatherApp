//
//  Weather.swift
//  weatherApp
//
//  Created by TimoXaq on 27/03/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit
import SwiftyJSON

class Weather: NSObject {
    
    var name: String?
    var latitude: Double
    var longitude: Double
    var condition: String?
    var weatherDescription: String?
    var windSpeed: String?
    var windDeg: Double?
    var clouds: String?
    var temp: String?
    var humidity: String?
    var visibility: String?
    var country: String?
    var sunrise: Int
    var sunset: Int
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.latitude = ceil(json["coord"]["lat"].doubleValue*1000)/1000
        self.longitude = ceil(json["coord"]["lon"].doubleValue*1000)/1000
        self.condition = json["weather"][0]["main"].stringValue
        self.weatherDescription = json["weather"][0]["description"].stringValue
        self.sunset = json["sys"]["sunset"].intValue
        self.sunrise = json["sys"]["sunrise"].intValue
        self.windSpeed = String(json["wind"]["speed"].doubleValue)+" m/s"
        self.windDeg = json["wind"]["deg"].doubleValue
        self.clouds = String(json["clouds"]["all"].doubleValue)
        self.temp = String(Int(json["main"]["temp"].doubleValue)) + "°"
        self.humidity = String(json["main"]["humidity"].doubleValue) + "%"
        self.visibility = String(json["visibility"].intValue) + "m"
        self.country = String(json["sys"]["country"].intValue)
    }
}
