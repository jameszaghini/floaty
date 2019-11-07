//
//  JavascriptPanelWindowController.swift
//  Floaty
//
//  Created by James Zaghini on 3/6/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

protocol JavascriptPanelDismissalDelegate: class {
    func didDismissJavascriptPanelWindowController(_ windowController: JavascriptPanelWindowController)
}

final class JavascriptAlertWindowController: JavascriptPanelWindowController {

    static let nibName = "JavascriptAlertWindowController"

    var completionHandler: (() -> Void)?

    // MARK: - Private

    @IBAction private func close(sender: Any?) {
        completionHandler?()
        dismiss()
    }
}

final class JavascriptConfirmWindowController: JavascriptPanelWindowController {

    static let nibName = "JavascriptConfirmWindowController"

    var completionHandler: ((Bool) -> Void)?

    // MARK: - Private

    @IBAction private func ok(sender: Any?) {
        completionHandler?(true)
        dismiss()
    }

    @IBAction private func cancel(sender: Any?) {
        completionHandler?(true)
        dismiss()
    }
}

class JavascriptPanelWindowController: NSWindowController {

    @IBOutlet private(set) var textView: NSTextView!

    weak var delegate: JavascriptPanelDismissalDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        textView.isEditable = false
    }

    // MARK: - Private

    fileprivate func dismiss() {
        delegate?.didDismissJavascriptPanelWindowController(self)
    }
}
