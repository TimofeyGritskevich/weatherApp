//
//  Locality.swift
//  weatherApp
//
//  Created by TimoXaq on 21/03/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift
import Realm

class Locality: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var country = ""
    @objc dynamic var lon = ""
    @objc dynamic var lat = ""
    @objc dynamic var id = ""
    @objc dynamic var favorite = false
 
    convenience init(json: JSON?) {
        self.init()
        guard let json = json else {return}
        
        self.name = json["name"].stringValue
        self.country = json["country"].stringValue
        self.lat = String(json["coord"]["lat"].doubleValue)
        self.lon = String(json["coord"]["lon"].doubleValue)
        self.id = String(json["id"].intValue)
        self.favorite = false
    }
}
