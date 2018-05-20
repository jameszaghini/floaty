//
//  Toolbar.swift
//  Floaty
//
//  Created by James Zaghini on 20/5/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

protocol ToolbarDelegate: class {
    func toolbar(_ toolBar: Toolbar, didChangeText text: String)
}

class Toolbar: NSToolbar, NSTextFieldDelegate {

    @IBOutlet private var urlTextField: NSTextField!

    weak var toolbarDelegate: ToolbarDelegate?

    // MARK: - NSTextFieldDelegate

    override func controlTextDidEndEditing(_ aNotification: Notification) {
        if aNotification.object as? NSTextField == urlTextField {
            toolbarDelegate?.toolbar(self, didChangeText: urlTextField.stringValue)
        }
    }
}

