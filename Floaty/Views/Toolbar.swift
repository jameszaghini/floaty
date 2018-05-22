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

    @IBOutlet private(set) var urlTextField: NSTextField!

    weak var toolbarDelegate: ToolbarDelegate?

    // MARK: - NSTextFieldDelegate

    override func controlTextDidEndEditing(_ aNotification: Notification) {
        guard
            let textField = aNotification.object as? NSTextField,
            let dict = aNotification.userInfo as? [String: Any],
            let code = dict["NSTextMovement"] as? Int else {
                return
        }

        if code == NSReturnTextMovement && textField == urlTextField {
            toolbarDelegate?.toolbar(self, didChangeText: textField.stringValue)
        }
    }
}
