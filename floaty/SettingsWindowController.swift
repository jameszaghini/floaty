//
//  SettingsWindowController.swift
//  Floaty
//
//  Created by James Zaghini on 9/6/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController, NSTextFieldDelegate, Serviceable {

    @IBOutlet private var homepageURLTextField: NSTextField!
    @IBOutlet private var opacitySlider: NSSlider!

    var settings = Services.shared.settings

    override func viewDidLoad() {
        homepageURLTextField.stringValue = settings.homepageURL
    }

    override func controlTextDidEndEditing(_ aNotification: Notification) {
        if aNotification.object as? NSTextField == homepageURLTextField {
            settings.homepageURL = homepageURLTextField.stringValue
        }
    }

    @IBAction func sliderChanged(_ sender: Any) {
        settings.windowOpacity = CGFloat(opacitySlider.floatValue)
    }
}
