//
//  SettingsViewControllerTests.swift
//  FloatyTests
//
//  Created by James Zaghini on 28/3/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import XCTest
@testable import Floaty

class SettingsViewControllerTests: XCTestCase {

    var viewController: SettingsViewController!
    let settings = Settings.load(storeFilename: "tests")

    override func setUp() {
        let storyboardName = "Main"
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let identifier = "SettingsViewController"
        viewController = storyboard.instantiateController(withIdentifier: identifier) as? SettingsViewController
        viewController.settings = settings
        viewController?.loadView()
    }

    func testHomepageURLStringChangesAfterEditing() {
        viewController.homepageURLTextField.stringValue = "http://www.google.com"
        let notification = Notification(name: Notification.Name("Name"), object: viewController.homepageURLTextField, userInfo: nil)
        viewController.controlTextDidEndEditing(notification)
        XCTAssertEqual(viewController.homepageURLTextField.stringValue, settings.homepageURLString)
    }

    func testCorrectURLShownInHomepageTextField() {
        XCTAssertEqual(viewController?.homepageURLTextField.stringValue, settings.homepageURLString)
    }

    func testChangingOpacitySliderUpdatesSetting() {
        let opacity: Float = 0.777
        let slider = NSSlider()
        slider.floatValue = opacity
        viewController.sliderChanged(slider)
        XCTAssertEqual(opacity, Float(settings.windowOpacity))
    }

}
