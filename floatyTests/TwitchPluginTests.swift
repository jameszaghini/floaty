//
//  TwitchPluginTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 22/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class TwitchPluginTests: XCTestCase {

    func testURLMassaged() {
        var url = URL(string: "https://twitch.tv/videos/351396422")!
        let plugin = TwitchPlugin()
        url = plugin.massageURL(url)
        XCTAssertEqual(url.absoluteString, "https://player.twitch.tv/?video=v351396422")
    }

}
