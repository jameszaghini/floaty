//
//  WebWindowController.swift
//  Floaty
//
//  Created by James Zaghini on 10/6/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

class WebWindowController: NSWindowController, Serviceable {

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.appearance = NSAppearance(named: .vibrantDark)
    }

}
