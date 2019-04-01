//
//  WebViewControllerMainView.swift
//  Floaty
//
//  Created by James Zaghini on 1/4/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import Foundation
import Cocoa

class WebViewControllerMainView: NSView {

    var services: Services? {
        didSet {
            guard let services = services else { return }
            setWindowBackgroundOpacity(services.settings.windowOpacity)
        }
    }
    private var disposable: Disposable?

    override func viewDidMoveToWindow() {
        disposable = services?.settings.windowOpacityObservable.observe { [weak self] opacity, _ in
            guard let opacity = opacity else { return }
            self?.setWindowBackgroundOpacity(opacity)
        }
    }

    // MARK: - Private

    private func setWindowBackgroundOpacity(_ opacity: CGFloat) {
        window?.backgroundColor = ColorPalette.background.withAlphaComponent(opacity)
        Log.info("opacity: \(opacity)")
    }
}
