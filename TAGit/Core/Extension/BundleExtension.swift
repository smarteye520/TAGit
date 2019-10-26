//
//  BundleExtension.swift
//  MondaysAtSix
//
//  Created by Macmini on 2/25/19.
//  Copyright © 2019 Onur Erdemol. All rights reserved.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
