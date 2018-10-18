//
//  String+Extension.swift
//  weatherApp
//
//  Created by Tima on 30.06.2018.
//  Copyright © 2018 TimoXaq. All rights reserved.
//

import Foundation

extension String {
    
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }   
}
