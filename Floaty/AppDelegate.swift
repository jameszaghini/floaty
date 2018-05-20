//
//  AppDelegate.swift
//  Floaty
//
//  Created by James Zaghini on 20/5/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let window = NSApplication.shared.mainWindow {
            window.appearance = NSAppearance(named: .vibrantDark)
            window.level = .floating
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

