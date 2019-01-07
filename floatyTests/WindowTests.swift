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

//    func testMouseExitedHidesToolbar() {
//        var webViewController: WebViewController?
//        let storyboardName = NSStoryboard.Name("Main")
//        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
//        let webWindowController = storyboard.instantiateInitialController() as? WebWindowController
//        webViewController = webWindowController?.window?.contentViewController as? WebViewController
//        webViewController?.loadView()
//
//        let window = webWindowController!.window!
//
//        window.mouseExited(with: NSEvent())
//        sleep(1)
//        XCTAssertEqual((window.toolbar as? Toolbar)?.urlTextField.alphaValue, 0)
//    }

}
