//
//  Toolbar.swift
//  Floaty
//
//  Created by James Zaghini on 20/5/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

protocol ToolbarDelegate: class {
    func toolbar(_ bar: Toolbar, didChangeText text: String)
}

class Toolbar: NSToolbar, NSTextFieldDelegate {

    @IBOutlet private(set) var urlTextField: URLTextField!

    weak var toolbarDelegate: ToolbarDelegate?

    // MARK: - NSTextFieldDelegate

    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        guard control == urlTextField else { return false }
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            toolbarDelegate?.toolbar(self, didChangeText: control.stringValue)
            return true
        }
        return false
    }

}
