//
//  CityInformation.swift
//  weatherApp
//
//  Created by TimoXaq on 21/03/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit

class CityInformation: NSObject {

    var name: String?
    var country: String?
    var id: Int?
    var lon: Double?
    var lat: Double?
    
    init(name: String?, country: String?, id: Int?, lon: Double?, lat: Double?) {
        self.name = name
        self.country = country
        self.id = id,
        self.lon = lon
        self.lat = lat
    }
}
