//
//  JavascriptAlertWindowControllerTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 19/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class JavascriptAlertWindowControllerTests: XCTestCase {

    func testMessageIsNotEditable() {
        let controller = JavascriptAlertWindowController(windowNibName: JavascriptAlertWindowController.nibName)
        controller.loadWindow()
        XCTAssertFalse(controller.textView.isEditable)
    }

}
