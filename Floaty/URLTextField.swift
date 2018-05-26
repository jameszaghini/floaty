//
//  URLTextField.swift
//  Floaty
//
//  Created by James Zaghini on 23/5/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

class URLTextField: NSTextField {

    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        currentEditor()?.selectAll(self)
    }

}
