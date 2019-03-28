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
    let settings = Services.shared.settings

    override func setUp() {
        let storyboardName = NSStoryboard.Name("Main")
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "SettingsViewController")
        viewController = storyboard.instantiateController(withIdentifier: identifier) as? SettingsViewController
        viewController?.loadView()
    }

    func testCorrectURLShownInHomepageTextField() {
        XCTAssertEqual(viewController?.homepageURLTextField.stringValue, settings.homepageURL)
    }

    func testChangingOpacitySliderUpdatesSetting() {
        let opacity: Float = 0.777
        viewController.opacitySlider.floatValue = opacity
        viewController.sliderChanged(viewController.opacitySlider)
        XCTAssertEqual(opacity, Float(settings.windowOpacity))
    }

}
