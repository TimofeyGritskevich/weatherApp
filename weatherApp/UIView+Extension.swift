//
//  UIView+Extension.swift
//  weatherApp
//
//  Created by Tima on 25.06.2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func setCellColorGradient(firstColor: UIColor, secondColor: UIColor) {

        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setConnectionProblemsAlert(controller: UIViewController) {

        let alert = UIAlertController(title: "Сonnection problems.", message: "Check the network connection on your deviceю", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
        }))
   
        controller.present(alert, animated: true, completion: nil)
    }
    
    func addParallaxToView(amount: Int) {
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        self.addMotionEffect(group)
    }
}

