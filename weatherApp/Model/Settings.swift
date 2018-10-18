//
//  Settings.swift
//  weatherApp
//
//  Created by TimoXaq on 13/04/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit

enum Units: String {
    case standart = "standart"
    case metric   = "metric"
    case imperial = "imperial"
}

enum TimeFormat: String {
    case twentyfour = "24"
    case twelve     = "12"
}

class Settings: NSObject, NSCoding {

    var metric: String
    var timeFormat: String
    
    init(metric: String, timeFormat: String) {
        self.metric = metric
        self.timeFormat = timeFormat
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let metric = aDecoder.decodeObject(forKey: "metric") as! String
        let timeFormat = aDecoder.decodeObject(forKey: "timeFormat") as! String
        self.init(metric: metric, timeFormat: timeFormat)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(metric, forKey: "metric")
        aCoder.encode(timeFormat, forKey: "timeFormat")
    }
    
    
}
