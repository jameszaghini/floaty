//
//  SettingsWindowController.swift
//  Floaty
//
//  Created by James Zaghini on 9/6/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController, NSTextFieldDelegate, Serviceable {

    @IBOutlet private(set) var homepageURLTextField: NSTextField!
    @IBOutlet private(set) var opacitySlider: NSSlider!
    @IBOutlet private(set) var searchProviderPopUpButton: NSPopUpButton!

    var settings = Services.shared.settings

    override func viewDidLoad() {
        homepageURLTextField.stringValue = settings.homepageURLString
        opacitySlider.floatValue = Float(settings.windowOpacity)
        setupSearchProviders()
    }

    func controlTextDidEndEditing(_ aNotification: Notification) {
        if aNotification.object as? NSTextField == homepageURLTextField {
            settings.homepageURLString = homepageURLTextField.stringValue
        }
    }

    @IBAction func sliderChanged(_ sender: Any) {
        guard let slider = sender as? NSSlider else { return }
        let opacity = CGFloat(slider.floatValue)
        settings.windowOpacity = opacity
    }

    @objc func searchProviderChanged(_ sender: NSMenuItem) {
        let provider = Search.allProviders.first(where: { $0.name == sender.title })?.identifier
        settings.activeSearchProviderId = provider ?? Search.defaultProvider.identifier
    }

    // MARK: - Private

    private func setupSearchProviders() {
        Search.allProviders.forEach {
            searchProviderPopUpButton.menu?.addItem(withTitle: $0.name,
                                                    action: #selector(SettingsViewController.searchProviderChanged(_:)),
                                                    keyEquivalent: "")

            if settings.activeSearchProviderId == $0.identifier {
                searchProviderPopUpButton.selectItem(withTitle: $0.name)
            }
        }
    }
}
