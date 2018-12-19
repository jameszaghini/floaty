//
//  JavascriptConfirmWindowControllerTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 19/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class JavascriptConfirmWindowControllerTests: XCTestCase {

    func testMessageIsNotEditable() {
        let controller = JavascriptConfirmWindowController(windowNibName: JavascriptConfirmWindowController.nibName)
        controller.loadWindow()
        XCTAssertFalse(controller.textView.isEditable)
    }

}
