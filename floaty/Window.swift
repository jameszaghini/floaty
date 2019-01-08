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

    private var initialWebViewConstraintConstant: CGFloat = 0
    private var webViewController: WebViewController? {
        return (windowController as? WebWindowController)?.contentViewController as? WebViewController
    }
    private var trackingArea: NSTrackingArea? {
        didSet {
            guard let trackingArea = trackingArea else { return }
            contentView?.addTrackingArea(trackingArea)
        }
    }

    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        isOpaque = false
        styleMask.insert(.fullSizeContentView)
        titlebarAppearsTransparent = true
        backgroundColor = ColorPalette.background.withAlphaComponent(Services.shared.settings.windowOpacity)
    }

    override func awakeFromNib() {
        trackingArea = NSTrackingArea(rect: contentView!.bounds, options: [.mouseEnteredAndExited, .activeAlways, .inVisibleRect], owner: self, userInfo: nil)
        initialWebViewConstraintConstant = webViewController?.topLayoutConstraint.constant ?? 0
    }

    override func mouseEntered(with event: NSEvent) {
        showToolbar(true)
    }

    override func mouseExited(with event: NSEvent) {
        showToolbar(false)
    }

    // MARK: - Private

    private func showToolbar(_ show: Bool) {
        if !show {
            self.toolbar?.showsBaselineSeparator = false
        }
        let alpha: CGFloat = show ? 1 : 0
        let urlTextField = (toolbar as? Toolbar)?.urlTextField
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.2
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            urlTextField?.animator().alphaValue = alpha
            trafficLightButtons().forEach {
                $0.animator().alphaValue = alpha
            }
            webViewController?.topLayoutConstraint.animator().constant = show ? initialWebViewConstraintConstant : 0
        }, completionHandler: {
            if urlTextField?.alphaValue == 1 {
                self.toolbar?.showsBaselineSeparator = true
            }
        })
    }

}
