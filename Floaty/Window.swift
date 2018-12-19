//
//  Window.swift
//  Floaty
//
//  Created by James Zaghini on 14/7/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

class Window: NSWindow {

    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        collectionBehavior = .canJoinAllSpaces
        level = .floating
    }
}

class WebWindow: Window {

    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        isOpaque = false
        styleMask.insert(.fullSizeContentView)
        titlebarAppearsTransparent = true
        backgroundColor = ColorPalette.background.withAlphaComponent(Services.shared.settings.windowOpacity)
    }
}
