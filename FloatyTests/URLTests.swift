//
//  URLTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 21/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class URLTests: XCTestCase {

    func testWWWShouldBePrefixedWithHttps() {
        let url = URL(string: "www.google.com")!
        let massaged = url.massagedURL()
        XCTAssertTrue(massaged.scheme ?? "" == "https")
    }

}
