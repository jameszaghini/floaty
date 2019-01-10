//
//  WebViewController.swift
//  Floaty
//
//  Created by James Zaghini on 20/5/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa
import WebKit

class WebViewController: NSViewController, ToolbarDelegate, WKUIDelegate, JavascriptPanelDismissalDelegate, Serviceable {

    @IBOutlet var topLayoutConstraint: NSLayoutConstraint!

    @IBOutlet private(set) var webView: WKWebView!
    @IBOutlet private var progressIndicator: NSProgressIndicator!

    private var webViewProgressObserver: NSKeyValueObservation?
    private var webViewURLObserver: NSKeyValueObservation?

    var browserAction: BrowserAction = .none {
        didSet {
            switch browserAction {
            case .visit(let url):
                self.url = url
            case .search(let query):
                guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { break }
                let searchProvider = Search.activeProvider(settings: Services.shared.settings)
                self.url = URL(string: searchProvider.searchURLString + encodedQuery)
            case .showError(let title, let message):
                webView.presentAnError(title: title, message: message)
                Log.info(message)
            case .none: break
            }
        }
    }

    private(set) var url: URL? {
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

    private var disposable: Disposable?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let toolbar = NSApplication.shared.windows.first?.toolbar as? Toolbar else { return }
        toolbar.toolbarDelegate = self

        disposable = services.settings.windowOpacityObservable.observe { [weak self] opacity, _ in
            self?.webView.alphaValue = opacity
            self?.view.window?.backgroundColor = ColorPalette.background.withAlphaComponent(opacity)
        }

        // Some sites won't work with the default user agent, so I've set this to the Safari user agent
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1.1 Safari/605.1.15"

        webViewProgressObserver = webView.observe(\.estimatedProgress) { [weak self ] (webView, _) in
            self?.progressIndicator.doubleValue = webView.estimatedProgress
            self?.progressIndicator.isHidden = webView.estimatedProgress == 1
        }

        webViewURLObserver = webView.observe(\.url) { (webView, _) in
            switch self.browserAction {
            case .visit(let url):
                toolbar.urlTextField.stringValue = url?.absoluteString ?? ""
            case .search:
                toolbar.urlTextField.stringValue = webView.url?.absoluteString ?? ""
            default: break
            }
        }

        if let url = URL(string: services.settings.homepageURL) {
            browserAction = .visit(url: url)
        }
    }

    // MARK: - ToolbarDelegate



    func toolbar(_ toolBar: Toolbar, didChangeText text: String) {
        browserAction = AddressBarInputHandler.actionFromEnteredText(text)
    }

    // MARK: - WKUIDelegate

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        // Open URLs that would open in a new window in the same web view
        if navigationAction.targetFrame == nil {
            browserAction = .visit(url: navigationAction.request.url)
        }
        return nil
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let controller = JavascriptConfirmWindowController(windowNibName: JavascriptConfirmWindowController.nibName)
        controller.completionHandler = completionHandler
        setupJavascriptWindowController(controller, message: message)
    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let controller = JavascriptAlertWindowController(windowNibName: JavascriptAlertWindowController.nibName)
        controller.completionHandler = completionHandler
        setupJavascriptWindowController(controller, message: message)
    }

    // MARK: - JavascriptPanelWindowControllerDelegate

    func didDismissJavascriptPanelWindowController(_ windowController: JavascriptPanelWindowController) {
        guard let window = view.window, let panelWindow = javascriptPanelWindowController?.window else { return }
        window.endSheet(panelWindow)
        javascriptPanelWindowController = nil
    }

    // MARK: - Private

    private func setupJavascriptWindowController(_ controller: JavascriptPanelWindowController, message: String) {
        controller.loadWindow()
        controller.delegate = self
        controller.textView.string = message
        javascriptPanelWindowController = controller
    }
}

extension WebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        handleError(error)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        handleError(error)
    }

    private func handleError(_ error: Error) {
        browserAction = .showError(title: "Floaty couldn't load the URL", message: error.localizedDescription)
    }
}
