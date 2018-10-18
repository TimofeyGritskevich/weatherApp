//
//  GradientView.swift
//  weatherApp
//
//  Created by Tima on 26.06.2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.clear
    @IBInspectable var secondColor: UIColor = UIColor.clear
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [firstColor.cgColor, secondColor.cgColor]
    }
}
