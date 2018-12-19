//
//  WindowTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 19/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class WindowTests: XCTestCase {

    func testWindowFloats() {
        let window = Window()
        XCTAssertEqual(window.level, .floating)
    }

}
