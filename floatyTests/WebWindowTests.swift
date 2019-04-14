//
//  WebWindowTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 27/3/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class WebWindowTests: XCTestCase {

    let window = WebWindow()

    func testMouseOver() {
        window.mouseEntered(with: NSEvent())
        XCTAssertTrue(window.isMouseOverWindow)
    }

    func testMouseExited() {
        window.mouseExited(with: NSEvent())
        XCTAssertFalse(window.isMouseOverWindow)
    }

}
