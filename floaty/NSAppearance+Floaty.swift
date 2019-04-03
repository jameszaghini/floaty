//
//  NSAppearance+Floaty.swift
//  Floaty
//
//  Created by James Zaghini on 2/4/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import Cocoa

extension NSAppearance {

    static let darkModeDefaultsKey = "AppleInterfaceStyle"
    static let darkModeAppearanceValue = "Dark"

    static func isDarkMode(_ defaults: UserDefaults) -> Bool {
        return defaults.string(forKey: darkModeDefaultsKey) == darkModeAppearanceValue
    }

}
