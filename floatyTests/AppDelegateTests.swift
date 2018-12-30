//
//  AppDelegateTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 30/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class AppDelegateTests: XCTestCase {

    func testApplicationShouldTerminateAfterLastWindowClosed() {
        let appDelegate = NSApplication.shared.delegate!
        let shouldTerminate = appDelegate.applicationShouldTerminateAfterLastWindowClosed!(NSApplication.shared)
        XCTAssertTrue(shouldTerminate)
    }

}
