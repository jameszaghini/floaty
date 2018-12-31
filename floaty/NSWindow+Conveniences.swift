//
//  NSWindow+Conveniences.swift
//  Floaty
//
//  Created by James Zaghini on 31/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

extension NSWindow {

    func trafficLightButtons() -> [NSButton] {
        let buttons = [
            standardWindowButton(.closeButton),
            standardWindowButton(.miniaturizeButton),
            standardWindowButton(.zoomButton),
        ]
        return buttons.compactMap { $0 }
    }

}
