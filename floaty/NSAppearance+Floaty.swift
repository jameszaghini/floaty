//
//  NSAppearance+Floaty.swift
//  Floaty
//
//  Created by James Zaghini on 2/4/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import Cocoa

extension NSAppearance {
    static var isDarkMode: Bool {
        let mode = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
        return mode == "Dark"
    }
}
