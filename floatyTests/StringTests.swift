//
//  StringTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 9/1/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class StringTests: XCTestCase {

    func testContainsWhitespace() {
        XCTAssertTrue("   ".containsWhitespace)
        XCTAssertFalse("1234".containsWhitespace)
    }

}
