//
//  UIWindow+Floaty.swift
//  Floaty
//
//  Created by James Zaghini on 24/5/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

extension NSWindow {

    func hideTrafficLights(_ hide: Bool) {
        contentView?.superview?.subviews.forEach({ subview in
            if subview.isKind(of: NSClassFromString("NSTitlebarContainerView")!) {
                let titlebarView = subview.subviews[0]
                titlebarView.subviews.forEach { $0.isHidden = ($0 is NSButton && hide)  }
            }
        })
    }

}
