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

    var viewController: WebViewController!
    var webView: WKWebView! { return viewController.webView! }

    let url = URL(string: "https://www.google.com")!

    override func setUp() {
        let storyboardName = NSStoryboard.Name("Main")
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let webWindowController = storyboard.instantiateInitialController() as? WebWindowController
        viewController = webWindowController?.window?.contentViewController as? WebViewController
        viewController?.loadView()
    }

    func testEnteringTextPerformsSearch() {
        let toolbar = NSApplication.shared.windows.first?.toolbar as? Toolbar
        viewController.toolbar(toolbar!, didChangeText: "grinch")
        XCTAssertTrue(viewController.browserAction == .search(text: "grinch"))
    }

    func testEnteringInToolbarChangesActiveURL() {
        let toolbar = NSApplication.shared.windows.first?.toolbar as? Toolbar
        viewController.toolbar(toolbar!, didChangeText: "https://www.google.com")
        XCTAssertTrue(webView.url!.absoluteString.hasPrefix(url.absoluteString))
    }

    func testURLThatShouldOpenInNewWindowOpensInSameWindow() {
        let config = WKWebViewConfiguration()
        let action = FakeNavigationAction(testRequest: URLRequest(url: url))
        let features = WKWindowFeatures()
        _ = viewController.webView(webView!, createWebViewWith: config, for: action, windowFeatures: features)
        XCTAssertTrue(viewController.browserAction == .visit(url: url))
    }

    func testDismissJavascriptPanelWindow() {
        XCTAssertNil(viewController.javascriptPanelWindowController)
        viewController.webView(webView, runJavaScriptAlertPanelWithMessage: "Message", initiatedByFrame: WKFrameInfo(), completionHandler: {})
        XCTAssertNotNil(viewController.javascriptPanelWindowController)
        viewController.didDismissJavascriptPanelWindowController(viewController.javascriptPanelWindowController!)
        XCTAssertNil(viewController.javascriptPanelWindowController)
    }

    func testJavascriptAlert() {
        XCTAssertNil(viewController.javascriptPanelWindowController)
        viewController.webView(webView, runJavaScriptAlertPanelWithMessage: "Message", initiatedByFrame: WKFrameInfo(), completionHandler: {})
        XCTAssertNotNil(viewController.javascriptPanelWindowController)
    }

    func testErrorWebPage() {
        print("xxx: 1")
        XCTAssertNil(viewController.html)
        print("xxx: 2")
        let title = "My Error title"
        let message = "My Error message"
        print("xxx: 3")
        viewController.browserAction = .showError(title: title, message: message)
        print("xxx: 4")
        XCTAssertNotNil(viewController.html)
        print("xxx: 5, ",  viewController.html)
        XCTAssertTrue(viewController.html!.contains(title))
        print("xxx: 6, ",  viewController.html)
        XCTAssertTrue(viewController.html!.contains(message))
        print("xxx: 7, ",  viewController.html)
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
