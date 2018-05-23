//
//  Toolbar.swift
//  Floaty
//
//  Created by James Zaghini on 20/5/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa
import HotKey

protocol ToolbarDelegate: class {
    func toolbar(_ toolBar: Toolbar, didChangeText text: String)
}

class Toolbar: NSToolbar, NSTextFieldDelegate {

    @IBOutlet var urlTextField: URLTextField!

    weak var toolbarDelegate: ToolbarDelegate?

    private let hotKey = HotKey(key: .f1, modifiers: [])

    override init(identifier: NSToolbar.Identifier) {
        super.init(identifier: identifier)
        hotKey.keyDownHandler = { [weak self] in
            self?.urlTextField.isEditable = true
            self?.urlTextField.becomeFirstResponder()
        }
    }

    // MARK: - NSTextFieldDelegate

    override func controlTextDidEndEditing(_ aNotification: Notification) {
        guard
            let textField = aNotification.object as? NSTextField,
            let dict = aNotification.userInfo as? [String: Any],
            let code = dict["NSTextMovement"] as? Int else {
                return
        }

        if code == NSReturnTextMovement && textField == urlTextField {
            urlTextField.isEditable = false
            toolbarDelegate?.toolbar(self, didChangeText: textField.stringValue)
        }
    }
}
