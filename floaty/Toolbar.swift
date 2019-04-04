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
    func toolbarForwardButtonWasPressed(_ toolbar: Toolbar)
    func toolbarBackButtonWasPressed(_ toolbar: Toolbar)
}

class Toolbar: NSToolbar, NSTextFieldDelegate {

    @IBOutlet private(set) var urlTextField: URLTextField!

    weak var toolbarDelegate: ToolbarDelegate?

    private var backImage: NSImage?
    private var forwardImage: NSImage?

    private let backItemIdentifier = NSToolbarItem.Identifier(rawValue: "back")
    private let forwardItemIdentifier = NSToolbarItem.Identifier(rawValue: "forward")

    override func awakeFromNib() {
        for item in items {
            if item.itemIdentifier == backItemIdentifier {
                backImage = item.image
            } else if item.itemIdentifier == forwardItemIdentifier {
                forwardImage = item.image
            }
        }
    }

    func removeButtons() {
        for item in items {
            if item.itemIdentifier == backItemIdentifier || item.itemIdentifier == forwardItemIdentifier {
                item.image = nil
            }
        }
    }

    func addButtons() {
        for item in items {
            if item.itemIdentifier == backItemIdentifier {
                item.image = backImage
            } else if item.itemIdentifier == forwardItemIdentifier {
                item.image = forwardImage
            }
        }
    }

    // MARK: - Private

    @IBAction private func back(sender: Any) {
        toolbarDelegate?.toolbarBackButtonWasPressed(self)
    }

    @IBAction private func forward(sender: Any) {
        toolbarDelegate?.toolbarForwardButtonWasPressed(self)
    }

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
