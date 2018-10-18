//
//  CityListCell.swift
//  weatherApp
//
//  Created by TimoXaq on 26/03/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit

class CityListCell: UITableViewCell {
 
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    func loadWith(locality: Locality) {
        cityLabel.text = locality.name
        countryLabel.text = locality.country
        if !locality.favorite {
            favoriteButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
            favoriteButton.tintColor = UIColor(red: 234/255, green: 224/255, blue: 138/255, alpha: 1)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "favoriteTrue"), for: .normal)
            favoriteButton.tintColor = UIColor(red: 245/255, green: 184/255, blue: 17/255, alpha: 1)
        }
    }
}
