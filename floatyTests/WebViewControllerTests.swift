//
//  WebViewControllerTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 23/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
import WebKit
@testable import Floaty

class WebViewControllerTests: XCTestCase {

    var webViewController: WebViewController!
    var webView: WKWebView {
        return webViewController.webView
    }

    let url = URL(string: "https://www.google.com")!

    override func setUp() {
        let storyboardName = NSStoryboard.Name("Main")
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let webWindowController = storyboard.instantiateInitialController() as? WebWindowController
        webViewController = webWindowController?.window?.contentViewController as? WebViewController
        webViewController?.loadView()
    }

    func testEnteringTextPerformsSearch() {
        let toolbar = NSApplication.shared.windows.first?.toolbar as? Toolbar
        webViewController.toolbar(toolbar!, didChangeText: "grinch")
        XCTAssertTrue(webViewController.browserAction == .search(text: "grinch"))
    }

    func testEnteringInToolbarChangesActiveURL() {
        let toolbar = NSApplication.shared.windows.first?.toolbar as? Toolbar
        webViewController.toolbar(toolbar!, didChangeText: "https://www.google.com")
        XCTAssertTrue(webViewController.webView.url!.absoluteString.hasPrefix(url.absoluteString))
    }

    func testURLThatShouldOpenInNewWindowOpensInSameWindow() {
        let config = WKWebViewConfiguration()
        let action = FakeNavigationAction(testRequest: URLRequest(url: url))
        let features = WKWindowFeatures()
        _ = webViewController.webView(webView, createWebViewWith: config, for: action, windowFeatures: features)
        XCTAssertTrue(webViewController.browserAction == .visit(url: url))
    }
}

class FakeNavigationAction: WKNavigationAction {
    let testRequest: URLRequest
    override var request: URLRequest {
        return testRequest
    }

    init(testRequest: URLRequest) {
        self.testRequest = testRequest
        super.init()
    }
}
