//
//  PrimitiveExtension.swift
//  MondaysAtSix
//
//  Created by Macmini on 2/28/19.
//  Copyright © 2019 Onur Erdemol. All rights reserved.
//

import Foundation
import Localize_Swift

extension Bool {
    var stringValue: String {
        if self {
            return "yes".localized()
        }
        else {
            return "no".localized()
        }
    }
}

extension Int {
    var inchesTofeetInches: String {
        let feet = self / 12
        let inches = self - (12 * feet)
        return "\(feet)'\(inches)\""
    }
}
