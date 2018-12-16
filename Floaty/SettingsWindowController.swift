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

    override func viewDidLoad() {
        homepageURLTextField.stringValue = services.settings.homepageURL
    }

    override func controlTextDidEndEditing(_ aNotification: Notification) {
        if aNotification.object as? NSTextField == homepageURLTextField {
            var settings = Services.shared.settings
            settings.homepageURL = homepageURLTextField.stringValue
        }
    }
}
