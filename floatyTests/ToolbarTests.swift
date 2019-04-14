//
//  ToolbarTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 12/4/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class ToolbarTests: XCTestCase {

    private var viewController: WebViewController!

    private var toolbar: Toolbar? {
        return viewController.view.window?.toolbar as? Toolbar
    }

    override func setUp() {
        let storyboardName = NSStoryboard.Name("Main")
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let webWindowController = storyboard.instantiateInitialController() as? WebWindowController
        viewController = webWindowController?.window?.contentViewController as? WebViewController
        viewController?.loadView()
    }

    func testAddButtons() {
        XCTAssertNotNil(toolbar)
        toolbar?.addButtons()
        XCTAssertNotNil(toolbar?.backItem?.image)
        XCTAssertNotNil(toolbar?.forwardItem?.image)
    }

    func testRemoveButtons() {
        XCTAssertNotNil(toolbar)
        toolbar?.removeButtons()
        XCTAssertNil(toolbar?.backItem?.image)
        XCTAssertNil(toolbar?.forwardItem?.image)
    }

}
