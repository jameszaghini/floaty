//
//  WebViewControllerTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 23/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class WebViewControllerTests: XCTestCase {

    var webViewController: WebViewController?

    override func setUp() {
        let storyboardName = NSStoryboard.Name("Main")
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let webWindowController = storyboard.instantiateInitialController() as? WebWindowController
        webViewController = webWindowController?.window?.contentViewController as? WebViewController
        webViewController?.loadView()
    }

    // TODO: This test is flaky
    func testSearchingChangesURL() {
        let toolbar = NSApplication.shared.windows.first?.toolbar as? Toolbar
        webViewController?.toolbar(toolbar!, didChangeText: "grinch")
        XCTAssertTrue(webViewController?.url?.absoluteString.hasSuffix("grinch") == true)
    }

    func testEnteringInToolbarChangesActiveURL() {
        let toolbar = NSApplication.shared.windows.first?.toolbar as? Toolbar
        webViewController?.toolbar(toolbar!, didChangeText: "https://www.google.com")
        XCTAssertEqual(webViewController?.url?.absoluteString, "https://www.google.com")
    }
}
