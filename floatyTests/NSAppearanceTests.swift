//
//  NSAppearanceTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 3/4/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class NSAppearanceTests: XCTestCase {

    func testIsDarkMode() {
        let defaults = MockUserDefaults()
        defaults.set("Monkey", forKey: NSAppearance.darkModeDefaultsKey)
        XCTAssertFalse(NSAppearance.isDarkMode(defaults))
        defaults.set(NSAppearance.darkModeAppearanceValue, forKey: NSAppearance.darkModeDefaultsKey)
        XCTAssertTrue(NSAppearance.isDarkMode(defaults))
    }
}
