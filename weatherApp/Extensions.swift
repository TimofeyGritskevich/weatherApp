//
//  Extensions.swift
//  weatherApp
//
//  Created by Tima on 04.10.2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension CLPlacemark {
    var compactAddress: String? {
        var result = ""
        if let city = locality {
            result += "\(city)"
        }
        if let street = thoroughfare {
            if result == "" {
                result += "\(street)"
            }
        }
        if let country = country {
            if result == "" {
                result += "\(country)"
            }
        }
        return result
    }
}

extension UIView {

    func animateGradient(gradient: CAGradientLayer, gradientSet:[[CGColor]], currentGradientIndex: Int) {
  
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
    
        var currentGradient = currentGradientIndex

        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        UIView.transition(with: self, duration: 2, options: [.transitionCrossDissolve], animations: {
            gradient.colors = gradientSet[currentGradientIndex]
        }) { (true) in
            self.animateGradient(gradient: gradient, gradientSet:gradientSet, currentGradientIndex: currentGradient)
        }
    }
    
    
    func setGradient(gradient: CAGradientLayer, colors:[CGColor]) {
        
        gradient.colors = colors
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}












