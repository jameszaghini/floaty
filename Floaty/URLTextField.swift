//
//  URLTextField.swift
//  Floaty
//
//  Created by James Zaghini on 23/5/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

class URLTextField: NSTextField {

    override func textDidEndEditing(_ notification: Notification) {
        super.textDidEndEditing(notification)
        isEditable = false
    }

}
