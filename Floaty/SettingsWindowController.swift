//
//  SettingsWindowController.swift
//  Floaty
//
//  Created by James Zaghini on 9/6/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa
import RxSwift

class SettingsViewController: NSViewController, Serviceable {

    @IBOutlet private var trafficLightsButton: NSButton!

    @IBAction private func didToggleTrafficLightsButton(sender: NSButton) {
        services.settings.trafficLightsEnabled.value = sender.state == .on
    }

    override func viewDidLoad() {
        trafficLightsButton.state = services.settings.trafficLightsEnabled.value ? .on : .off
    }

}
