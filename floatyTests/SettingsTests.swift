//
//  SettingsTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 16/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class SettingsTests: XCTestCase {

    var disposable: Disposable?
    let storeFilename = "tests"

    func testChangingHomepageURLSaves() {
        let settings = Settings.load(storeFilename: storeFilename)
        let urlString = "http://www.duckduckgo.com"
        settings.homepageURLString = urlString
        let settings2 = Settings.load(storeFilename: storeFilename)
        XCTAssertEqual(settings2.homepageURLString, urlString)
    }

    func testChangingWindowOpacityFiresObserver() {

        let settings = Settings.load(storeFilename: storeFilename)
        let newOpacity: CGFloat = 0.05

        let promise = expectation(description: "Observer will fire on opacity change")

        disposable = settings.windowOpacityObservable.observe { opacity, _ in
            guard opacity == newOpacity else { return }
            promise.fulfill()
        }

        settings.windowOpacity = newOpacity

        waitForExpectations(timeout: 3) { _ in
            XCTAssertEqual(settings.windowOpacity, newOpacity, accuracy: CGFloat.ulpOfOne)
        }
    }
}
