//
//  VimeoPluginTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 21/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class VimeoPluginTests: XCTestCase {

    func testURLMassaged() {
        var url = URL(string: "https://vimeo.com/176121677")!
        let plugin = VimeoPlugin()
        url = plugin.massageURL(url)!
        XCTAssertTrue(url.absoluteString.hasPrefix("https://player.vimeo.com/video/176121677"))
    }
}
