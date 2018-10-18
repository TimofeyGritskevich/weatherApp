//
//  NetworkManager.swift
//  weatherApp
//
//  Created by TimoXaq on 20/03/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import RealmSwift

class NetworkManager: NSObject, CLLocationManagerDelegate {
 
    static var weatherKey = "APPID=4ea35056b5cd9c9cf8464ad59fde63f1"
    
    static func getCityList(completion: @escaping (_ array:[Locality]) -> ()) {
        if let path = Bundle.main.path(forResource: "current.city.list", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            request(url).responseJSON { responseJSON in
                
                DispatchQueue.global().async(execute: {
                    let list =  responseJSON.result.value as! [[String: Any]]
                    var localityArray = [Locality]()
                    for json in list {
                        localityArray.append(Locality.init(json: JSON(json)))
                    }
                    completion(localityArray)
                }) 
            }
        }
    }
 
    static func getWeatherForActualPlace(latitude: String, longitude: String, completion: @escaping (Weather) -> ()) {

        request("http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&lang=en&\(weatherKey)").responseJSON { responseJSON in
            let json = JSON(responseJSON.result.value as Any)
            completion(Weather(json: json))
        }
    }
    
    static func getWeatherById (id: String, completion: @escaping (Weather) -> ()) {
        request("http://api.openweathermap.org/data/2.5/weather?id=\(id)&units=metric&lang=en&\(weatherKey)").responseJSON { responseJSON in
            let json = JSON(responseJSON.result.value as Any)
            completion(Weather(json: json))
        }
    }
    
    static func getWeatherByGroup (list:Results<Locality>, completion:@escaping ([Weather]) -> ()) {
        
        let idList = Manager.getIdStringFromLocalityList(localityList: list)
        request("http://api.openweathermap.org/data/2.5/group?id=\(idList)&units=metric&lang=en&\(weatherKey)").responseJSON { responseJSON in
            let json = JSON(responseJSON.result.value as Any)["list"]
            var array: [Weather] = []
            for city in json {
                array.append(Weather.init(json: city.1))
            }
            completion(array)
        }
    }
}
