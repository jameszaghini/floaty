//
//  WebViewController.swift
//  Floaty
//
//  Created by James Zaghini on 20/5/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa
import WebKit

class WebViewController: NSViewController, ToolbarDelegate, WKNavigationDelegate, WKUIDelegate, JavascriptPanelDismissalDelegate {

    @IBOutlet private var webView: WKWebView!
    @IBOutlet private var progressIndicator: NSProgressIndicator!

    private var webViewProgressObserver: NSKeyValueObservation?
    private var webViewURLObserver: NSKeyValueObservation?

    private var url: URL? {
        didSet {
            guard let url = url else { return }
            let request = URLRequest(url: url.massagedURL())
            webView.load(request)
        }
    }

    private var javascriptPanelWindowController: JavascriptPanelWindowController? {
        didSet {
            guard let panelWindow = javascriptPanelWindowController?.window else { return }
            view.window?.beginSheet(panelWindow)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let toolbar = NSApplication.shared.windows.first?.toolbar as? Toolbar else { return }
        toolbar.toolbarDelegate = self

        webViewProgressObserver = webView.observe(\.estimatedProgress) { [weak self ] (webView, _) in
            self?.progressIndicator.doubleValue = webView.estimatedProgress
            self?.progressIndicator.isHidden = webView.estimatedProgress == 1
        }

        webViewURLObserver = webView.observe(\.URL) { (webView, _) in
            if let urlString = webView.url?.absoluteString, urlString != toolbar.urlTextField.stringValue {
                toolbar.urlTextField.stringValue = urlString
            }
        }

        url = URL(string: "https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_confirm"/*http://en.wikipedia.org/wiki/Special:Random"*/)!
    }

    // MARK: - ToolbarDelegate

    var windowController: NSWindowController?

    func toolbar(_ toolBar: Toolbar, didChangeText text: String) {
        url = URL(string: text)
    }

    // MARK: - WKNavigationDelegate

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error)
    }

    // MARK: - WKUIDelegate

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        // Open URLs that would open in a new window in the same web view
        url = navigationAction.request.url
        return nil
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let controller = JavascriptConfirmWindowController(windowNibName: NSNib.Name("JavascriptConfirmWindowController"))
        controller.loadWindow()
        controller.delegate = self
        controller.textView.string = message
        controller.completionHandler = completionHandler
        javascriptPanelWindowController = controller
    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let controller = JavascriptAlertWindowController(windowNibName: NSNib.Name("JavascriptAlertWindowController"))
        controller.loadWindow()
        controller.delegate = self
        controller.textView.string = message
        controller.completionHandler = completionHandler
        javascriptPanelWindowController = controller
    }

    // MARK: - JavascriptPanelWindowControllerDelegate

    func didDismissJavascriptPanelWindowController(_ windowController: JavascriptPanelWindowController) {
        guard let window = view.window, let panelWindow = javascriptPanelWindowController?.window else { return }
        window.endSheet(panelWindow)
        javascriptPanelWindowController = nil
    }
}
