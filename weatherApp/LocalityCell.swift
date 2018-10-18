//
//  LocalityCell.swift
//  weatherApp
//
//  Created by TimoXaq on 21/03/2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit

class LocalityCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    func loadWith(locality: Locality) {
//        self.cityNameLabel.text = locality.name
//        self.countryNameLabel.text = locality.country
//    }
    
}
