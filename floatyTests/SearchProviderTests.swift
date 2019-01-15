//
//  SearchProviderTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 22/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class SearchProviderTests: XCTestCase {

    var userDefaults: UserDefaults!
    let userDefaultsSuiteName = "TestDefaults"

    override func setUp() {
        super.setUp()
        UserDefaults().removePersistentDomain(forName: userDefaultsSuiteName)
        userDefaults = UserDefaults(suiteName: userDefaultsSuiteName)
    }

    func testDefaultProviderReturnedIfNoneChosenByUser() {
        let settings = Settings.load(defaults: userDefaults)
        let activeProvider = Search.activeProvider(settings: settings)
        XCTAssert(activeProvider.providerId == Search.defaultProvider.providerId)
    }

    func testNonDefaultProviderReturnedIfChangedByUser() {
        var settings = Settings.load(defaults: userDefaults)
        settings.searchProviderId = Google().providerId
        let activeProvider = Search.activeProvider(settings: settings)
        XCTAssert(activeProvider.providerId == settings.searchProviderId)
    }

}
