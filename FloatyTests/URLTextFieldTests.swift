//
//  URLTextFieldTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 20/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class URLTextFieldTests: XCTestCase {

    func testAllSelectedOnMouseDown() {
        let textField = URLTextField(frame: .zero)
        XCTAssertEqual(textField.selectedCell()?.stringValue, "")

        textField.stringValue = "test"
        textField.mouseDown(with: NSEvent())
        XCTAssertEqual(textField.stringValue, textField.selectedCell()?.stringValue)
    }
}
