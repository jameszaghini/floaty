//
//  AddressBarInputHandler.swift
//  FloatyTests
//
//  Created by James Zaghini on 5/1/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class AddressBarInputHandlerTests: XCTestCase {

    func testEmptyStringDoesNothing() {
        let text = ""
        let expectedAction = BrowserAction.none
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testWhitespaceStringDoesNothing() {
        let text = "   "
        let expectedAction = BrowserAction.none
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testSingleWordDoesWebSearch() {
        let text = "lobster"
        let expectedAction = BrowserAction.search(text: text)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testWordsDoesWebSearch() {
        let text = "lobster soup"
        let expectedAction = BrowserAction.search(text: text)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testHostWithPathReturnsURL() {
        let text = "abc.net.au/news"
        let url = URL(string: "https://" + text)!
        let expectedAction = BrowserAction.visit(url: url)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testRedditDotComReturnsURL() {
        let text = "reddit.com"
        let url = URL(string: "https://" + text)!
        let expectedAction = BrowserAction.visit(url: url)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testRedditWithHttpReturnsURL() {
        let text = "http://reddit.com"
        let url = URL(string: text)!
        let expectedAction = BrowserAction.visit(url: url)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testDogDotCatReturnsURL() {
        let text = "dog.cat"
        let url = URL(string: "https://" + text)!
        let expectedAction = BrowserAction.visit(url: url)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testDogDotCatDotRabbitDoesWebSearch() {
        let text = "dog.cat.rabbit"
        let expectedAction = BrowserAction.search(text: text)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testIPAddressReturnsURL() {
        let text = "http://127.0.0.1:8000/v7/admin/"
        let url = URL(string: text)!
        let expectedAction = BrowserAction.visit(url: url)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testOutOfRangeIPAddressSearches() {
        let text = "http://256.0.0.1:8000/v7/admin/"
        let expectedAction = BrowserAction.search(text: text)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testNotEnoughPartsInIPAddressSearches() {
        let text = "http://0.0.1:8000/v7/admin/"
        let expectedAction = BrowserAction.search(text: text)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testABCDoesWebSearch() {
        let text = "abc"
        let expectedAction = BrowserAction.search(text: text)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func test127WithPort() {
        let text = "http://127.0.0.1:1313"
        let url = URL(string: text)!
        let expectedAction = BrowserAction.visit(url: url)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }

    func testLocalHostWithPort() {
        let text = "http://localhost:1313"
        let url = URL(string: text)!
        let expectedAction = BrowserAction.visit(url: url)
        let action = AddressBarInputHandler.actionFromEnteredText(text)
        XCTAssertEqual(action, expectedAction)
    }
}
