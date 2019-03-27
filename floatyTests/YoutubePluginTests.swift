//
//  YoutubePluginTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 21/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class YoutubePluginTests: XCTestCase {

    func testShouldCreateEmbedURLFromWatchURL() {
        var url = URL(string: "https://www.youtube.com/watch?v=hHW1oY26kxQ")!
        let plugin = YoutubePlugin()
        url = plugin.massageURL(url)!
        XCTAssertTrue(url.absoluteString.hasPrefix("https://www.youtube.com/embed/hHW1oY26kxQ"))
    }

    func testYoutubeShortURL() {
        var url = URL(string: "http://youtu.be/hHW1oY26kxQ")!
        let plugin = YoutubePlugin()
        url = plugin.massageURL(url)!
        XCTAssertTrue(url.absoluteString.hasPrefix("https://www.youtube.com/embed/hHW1oY26kxQ"))
    }

}
