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
        let storyboardName = NSStoryboard.Name("Main")
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "SettingsViewController")
        viewController = storyboard.instantiateController(withIdentifier: identifier) as? SettingsViewController
        viewController.settings = settings
        viewController?.loadView()
    }

    func testCorrectURLShownInHomepageTextField() {
        XCTAssertEqual(viewController?.homepageURLTextField.stringValue, settings.homepageURLString)
    }

    func testChangingOpacitySliderUpdatesSetting() {
        let opacity: Float = 0.777
        let slider = NSSlider()
        slider.floatValue = opacity
        viewController.sliderChanged(slider)

        print("settings in tests: ", settings)
        XCTAssertEqual(opacity, Float(viewController.settings.windowOpacity))
    }

}
