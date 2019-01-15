//
//  ErrorHandlerTests.swift
//  Floaty
//
//  Created by James Zaghini on 9/1/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class ErrorHandlerTests: XCTestCase {

    func testTryThatFailsReturnsNil() {
        let value = ErrorHandler.shared.wrap { try String(contentsOfFile: "blah") }
        XCTAssertNil(value)
    }

}
