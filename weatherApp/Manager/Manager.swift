//
//  Manager.swift
//  weatherApp
//
//  Created by TimoXaq on 10/04/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit
import SwiftyJSON
import Realm
import RealmSwift

class Manager: NSObject {

    static let realm = try! Realm()
    static var result: Results<Locality>{
        get {
            return realm.objects(Locality.self)
        }
    }
    
    static var globalColor = [#colorLiteral(red: 0.4397572875, green: 0.6228223443, blue: 0.9524775147, alpha: 1).cgColor, #colorLiteral(red: 0.8634838462, green: 0.6744642258, blue: 0.799803555, alpha: 1).cgColor]
    static var actualLocality = ""
    static var actualLon = ""
    static var actualLat = ""
    static var localityList: [Locality] = []
    static let colorArray = [[#colorLiteral(red: 0.4397572875, green: 0.6228223443, blue: 0.9524775147, alpha: 1).cgColor, #colorLiteral(red: 0.8634838462, green: 0.6744642258, blue: 0.799803555, alpha: 1).cgColor],
                      [#colorLiteral(red: 0.9964181781, green: 0.7613053918, blue: 0.4594445229, alpha: 1).cgColor, #colorLiteral(red: 0.6046620011, green: 0.5407747626, blue: 0.7878979445, alpha: 1).cgColor],
                      [#colorLiteral(red: 0.4397572875, green: 0.6228223443, blue: 0.9524775147, alpha: 1).cgColor, #colorLiteral(red: 0.8634838462, green: 0.6744642258, blue: 0.799803555, alpha: 1).cgColor]]
    
    static let timeFirstColorArray = ["ClearD": #colorLiteral(red: 0.6185656786, green: 0.8352465034, blue: 0.81555897, alpha: 1).cgColor,
                                "CloudsD": #colorLiteral(red: 0.8321697116, green: 0.6273880601, blue: 0.76842314, alpha: 1).cgColor,
                                "DrizzleD": #colorLiteral(red: 1, green: 0.7613086104, blue: 0.4594472647, alpha: 1).cgColor,
                                "DustD": #colorLiteral(red: 0.8718079925, green: 0.3768132329, blue: 0.5058484077, alpha: 1).cgColor,
                                "FogD": #colorLiteral(red: 0.8718079925, green: 0.3768132329, blue: 0.5058484077, alpha: 1).cgColor,
                                "HazeD": #colorLiteral(red: 0.8718079925, green: 0.3768132329, blue: 0.5058484077, alpha: 1).cgColor,
                                "MistD": #colorLiteral(red: 0.8718079925, green: 0.3768132329, blue: 0.5058484077, alpha: 1).cgColor,
                                "RainD": #colorLiteral(red: 1, green: 0.7613086104, blue: 0.4594472647, alpha: 1).cgColor,
                                "SandD": #colorLiteral(red: 0.8718079925, green: 0.3768132329, blue: 0.5058484077, alpha: 1).cgColor,
                                "SleetD": #colorLiteral(red: 0.4397230744, green: 0.6267531514, blue: 0.9524796605, alpha: 1).cgColor,
                                "SmokeD": #colorLiteral(red: 0.8718079925, green: 0.3768132329, blue: 0.5058484077, alpha: 1).cgColor,
                                "SnowD": #colorLiteral(red: 0.4397230744, green: 0.6267531514, blue: 0.9524796605, alpha: 1).cgColor,
                                "SquallsD": #colorLiteral(red: 0.8321697116, green: 0.6273880601, blue: 0.76842314, alpha: 1).cgColor,
                                "StormD": #colorLiteral(red: 0.4397572875, green: 0.6228223443, blue: 0.9524775147, alpha: 1).cgColor,
                                "ThunderstormD": #colorLiteral(red: 1, green: 0.7613086104, blue: 0.4594472647, alpha: 1).cgColor,
                                "TornadoD": #colorLiteral(red: 1, green: 0.7613086104, blue: 0.4594472647, alpha: 1).cgColor,
                                "ClearN": #colorLiteral(red: 0.06636611372, green: 0.2311197221, blue: 0.341000706, alpha: 1).cgColor,
                                "CloudsN": #colorLiteral(red: 0.3261278868, green: 0.2741260231, blue: 0.4781852365, alpha: 1).cgColor,
                                "DrizzleN": #colorLiteral(red: 0.4706440568, green: 0.5018318892, blue: 0.5841374993, alpha: 1).cgColor,
                                "DustN": #colorLiteral(red: 0.3938853741, green: 0.1268526912, blue: 0.6740791202, alpha: 1).cgColor,
                                "FogN": #colorLiteral(red: 0.3938853741, green: 0.1268526912, blue: 0.6740791202, alpha: 1).cgColor,
                                "HazeN": #colorLiteral(red: 0.3938853741, green: 0.1268526912, blue: 0.6740791202, alpha: 1).cgColor,
                                "MistN": #colorLiteral(red: 0.3938853741, green: 0.1268526912, blue: 0.6740791202, alpha: 1).cgColor,
                                "RainN": #colorLiteral(red: 0.4706440568, green: 0.5018318892, blue: 0.5841374993, alpha: 1).cgColor,
                                "SandN": #colorLiteral(red: 0.3938853741, green: 0.1268526912, blue: 0.6740791202, alpha: 1).cgColor,
                                "SleetN": #colorLiteral(red: 0.06636611372, green: 0.2311197221, blue: 0.341000706, alpha: 1).cgColor,
                                "SmokeN": #colorLiteral(red: 0.3938853741, green: 0.1268526912, blue: 0.6740791202, alpha: 1).cgColor,
                                "SnowN": #colorLiteral(red: 0.06636611372, green: 0.2311197221, blue: 0.341000706, alpha: 1).cgColor,
                                "SquallsN": #colorLiteral(red: 0.3261278868, green: 0.2741260231, blue: 0.4781852365, alpha: 1).cgColor,
                                "StormN": #colorLiteral(red: 0.4397572875, green: 0.6228223443, blue: 0.9524775147, alpha: 1).cgColor,
                                "ThunderstormN": #colorLiteral(red: 0.4706440568, green: 0.5018318892, blue: 0.5841374993, alpha: 1).cgColor,
                                "TornadoN": #colorLiteral(red: 0.4706440568, green: 0.5018318892, blue: 0.5841374993, alpha: 1).cgColor]
    
    static let timeSecondColorArray = ["ClearD": #colorLiteral(red: 0.3421605229, green: 0.3130367696, blue: 0.6192623377, alpha: 1).cgColor,
                                 "CloudsD": #colorLiteral(red: 0.7108575702, green: 0.3959667683, blue: 0.6076288819, alpha: 1).cgColor,
                                 "DrizzleD": #colorLiteral(red: 0.5811280012, green: 0.5211598277, blue: 0.7682930827, alpha: 1).cgColor,
                                 "DustD": #colorLiteral(red: 0.840190351, green: 0.6037608385, blue: 0.8075792789, alpha: 1).cgColor,
                                 "FogD": #colorLiteral(red: 0.840190351, green: 0.6037608385, blue: 0.8075792789, alpha: 1).cgColor,
                                 "HazeD": #colorLiteral(red: 0.840190351, green: 0.6037608385, blue: 0.8075792789, alpha: 1).cgColor,
                                 "MistD": #colorLiteral(red: 0.840190351, green: 0.6037608385, blue: 0.8075792789, alpha: 1).cgColor,
                                 "RainD": #colorLiteral(red: 0.5811280012, green: 0.5211598277, blue: 0.7682930827, alpha: 1).cgColor,
                                 "SandD": #colorLiteral(red: 0.8634838462, green: 0.6744642258, blue: 0.799803555, alpha: 1).cgColor,
                                 "SleetD": #colorLiteral(red: 0.8595548272, green: 0.6705495715, blue: 0.7919657826, alpha: 1).cgColor,
                                 "SmokeD": #colorLiteral(red: 0.840190351, green: 0.6037608385, blue: 0.8075792789, alpha: 1).cgColor,
                                 "SnowD": #colorLiteral(red: 0.8595548272, green: 0.6705495715, blue: 0.7919657826, alpha: 1).cgColor,
                                 "SquallsD": #colorLiteral(red: 0.7108575702, green: 0.3959667683, blue: 0.6076288819, alpha: 1).cgColor,
                                 "StormD": #colorLiteral(red: 0.8634838462, green: 0.6744642258, blue: 0.799803555, alpha: 1).cgColor,
                                 "ThunderstormD": #colorLiteral(red: 0.5811280012, green: 0.5211598277, blue: 0.7682930827, alpha: 1).cgColor,
                                 "TornadoD": #colorLiteral(red: 0.5811280012, green: 0.5211598277, blue: 0.7682930827, alpha: 1).cgColor,
                                 "ClearN": #colorLiteral(red: 0.7494699359, green: 0.6704748273, blue: 0.7880197167, alpha: 1).cgColor,
                                 "CloudsN": #colorLiteral(red: 0.8164661527, green: 0.6156268716, blue: 0.7527421117, alpha: 1).cgColor,
                                 "DrizzleN": #colorLiteral(red: 0.4542974234, green: 0.6351222396, blue: 0.705675602, alpha: 1).cgColor,
                                 "DustN": #colorLiteral(red: 0.6325888038, green: 0.1957781911, blue: 0.517409265, alpha: 1).cgColor,
                                 "FogN": #colorLiteral(red: 0.6325888038, green: 0.1957781911, blue: 0.517409265, alpha: 1).cgColor,
                                 "HazeN": #colorLiteral(red: 0.6325888038, green: 0.1957781911, blue: 0.517409265, alpha: 1).cgColor,
                                 "MistN": #colorLiteral(red: 0.6325888038, green: 0.1957781911, blue: 0.517409265, alpha: 1).cgColor,
                                 "RainN": #colorLiteral(red: 0.4542974234, green: 0.6351222396, blue: 0.705675602, alpha: 1).cgColor,
                                 "SandN": #colorLiteral(red: 0.6325888038, green: 0.1957781911, blue: 0.517409265, alpha: 1).cgColor,
                                 "SleetN": #colorLiteral(red: 0.7729905248, green: 0.6940124631, blue: 0.8076291084, alpha: 1).cgColor,
                                 "SmokeN": #colorLiteral(red: 0.6325888038, green: 0.1957781911, blue: 0.517409265, alpha: 1).cgColor,
                                 "SnowN": #colorLiteral(red: 0.7729905248, green: 0.6940124631, blue: 0.8076291084, alpha: 1).cgColor,
                                 "SquallsN": #colorLiteral(red: 0.8164661527, green: 0.6156268716, blue: 0.7527421117, alpha: 1).cgColor,
                                 "StormN": #colorLiteral(red: 0.8634838462, green: 0.6744642258, blue: 0.799803555, alpha: 1).cgColor,
                                 "ThunderstormN": #colorLiteral(red: 0.4542974234, green: 0.6351222396, blue: 0.705675602, alpha: 1).cgColor,
                                 "TornadoN": #colorLiteral(red: 0.4542974234, green: 0.6351222396, blue: 0.705675602, alpha: 1).cgColor]
    
        static func getIdStringFromLocalityList(localityList: Results<Locality>) -> String {
        
        var stringWithId: String = ""
        let list = localityList
        for city in list {
            stringWithId = stringWithId + city.id + ","
        }
        if stringWithId != "" {
            stringWithId.removeLast()
        }
        return stringWithId
    }
    
    static func setWeatherImage(condition: String, sunsetTime: Int, sunriseTime: Int) -> String {
        let timesOfDay = self.setTime(sunsetTime: sunsetTime, sunriseTime: sunriseTime)
        return condition + timesOfDay
    }
    
    static func setTime (sunsetTime: Int, sunriseTime: Int) -> String {
        
        let time = Int(NSDate().timeIntervalSince1970)
        let dayLong = sunsetTime - sunriseTime
        let night = 86400 - dayLong
        var timesOfDay = "D"
        var interval = time - sunsetTime
        if (time - sunsetTime) > 0 {
            if interval > 0 {
                if interval > 86400 {
                    interval = interval - 86400
                }
            }
            if interval < night {
                timesOfDay = "N"
            }
        } else {     
            if interval < -86400 {
                interval = interval + 86400
            }
            if interval * (-1) > dayLong {
                timesOfDay = "N"
            }
        }
        return timesOfDay
    }
    
    static func setTimeFromUnix(unixTime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        return dateFormatter.string(from: date)
    }
    
    static func setWindDirection (degree: Double) -> String {
       
        var direction = ""
      
        if degree > 337.0 || degree <= 22.0 {
            direction = "N"
        }
        if degree > 22.0 || degree <= 67.0 {
            direction = "NE"
        }
        if degree > 67.0 || degree <= 112.0 {
            direction = "E"
        }
        if degree > 112.0 || degree <= 157.0 {
            direction = "SE"
        }
        if degree > 157.0 || degree <= 202.0 {
            direction = "S"
        }
        if degree > 202.0 || degree <= 247.0 {
            direction = "SW"
        }
        if degree > 247.0 || degree <= 292.0 {
            direction = "W"
        }
        if degree > 292.0 || degree <= 337.0 {
            direction = "NW"
        }
        return direction
    }
}






