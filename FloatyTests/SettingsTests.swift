//
//  SettingsTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 16/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class SettingsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testChangingHomepageURLSaves() {
        var settings = Settings.load()
        let urlString = "http://www.duckduckgo.com"
        settings.homepageURL = urlString
        let settings2 = Settings.load()
        XCTAssertEqual(settings2.homepageURL, urlString)
    }

}
