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

    private(set) var html: String? {
        didSet {
            guard let html = html else { return }
            webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
        }
    }

    var browserAction: BrowserAction = .none {
        didSet {

            func loadURL(_ url: URL?) {
                guard let url = url else { return }
                let request = URLRequest(url: url)
                webView.load(request)
            }

            switch browserAction {
            case .visit(let url):
                loadURL(url)
            case .search(let query):
                guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { break }
                let searchProvider = Search.activeProvider(settings: Services.shared.settings)
                let url = URL(string: searchProvider.searchURLString + encodedQuery)
                loadURL(url)
            case .showError(let title, let message):
                presentErrorWebPage(title: title, message: message)
                Log.info(title + " " + message)
            case .none: break
            }
        }
    }

    private var toolbar: Toolbar? {
        return view.window?.toolbar as? Toolbar
    }

    private var urlTextField: URLTextField? {
        return toolbar?.urlTextField
    }

    private(set) var javascriptPanelWindowController: JavascriptPanelWindowController? {
        didSet {
            guard let panelWindow = javascriptPanelWindowController?.window else { return }
            view.window?.beginSheet(panelWindow)
        }
    }

    private var disposable: Disposable?
    private var keyDownEventMonitor: Any?

    deinit {
        if let keyDownEventMonitor = keyDownEventMonitor {
            NSEvent.removeMonitor(keyDownEventMonitor)
        }
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        toolbar?.toolbarDelegate = self
        startObservingURL()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        disposable = services.settings.windowOpacityObservable.observe { [weak self] opacity, _ in
            guard let opacity = opacity else { return }
            self?.webViewOpacity(opacity)
        }
        webViewOpacity(services.settings.windowOpacity)

        (view as? WebViewControllerMainView)?.services = services

        // Some sites won't work with the default user agent, so I've set this to the Safari user agent
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1.1 Safari/605.1.15"

        webViewProgressObserver = webView.observe(\.estimatedProgress) { [weak self] (webView, _) in
            self?.progressIndicator.doubleValue = webView.estimatedProgress
            self?.progressIndicator.isHidden = webView.estimatedProgress == 1
        }

        if let url = URL(string: services.settings.homepageURLString) {
            browserAction = .visit(url: url)
        }

        keyDownEventMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [unowned self] in
            return self.handleKeyDown(with: $0) ? nil : $0
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        // Prevents the user getting stuck on the same webpage after
        // pressing back when viewing a massaged URL
        if navigationAction.navigationType == .backForward, navigationAction.request.url?.massagedURL() != nil {
            decisionHandler(.cancel)
            webView.goBack()
            return
        }

        decisionHandler(.allow)
    }

    // MARK: - ToolbarDelegate

    func toolbar(_ bar: Toolbar, didChangeText text: String) {
        browserAction = AddressBarInputHandler.actionFromEnteredText(text)
        if webView.acceptsFirstResponder {
            webView.window?.makeFirstResponder(webView)
        }
    }

    func toolbarForwardButtonWasPressed(_ toolbar: Toolbar) {
        webView.goForward()
    }

    func toolbarBackButtonWasPressed(_ toolbar: Toolbar) {
        webView.goBack()
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

    private func webViewOpacity(_ opacity: CGFloat) {
        webView.alphaValue = opacity
    }

    private func setupJavascriptWindowController(_ controller: JavascriptPanelWindowController, message: String) {
        controller.loadWindow()
        controller.delegate = self
        controller.textView.string = message
        javascriptPanelWindowController = controller
    }

    private func handleKeyDown(with event: NSEvent) -> Bool {
        switch event.charactersIgnoringModifiers {
        case "l":
            if event.modifierFlags.contains(.command) {
                return makeURLTextFieldFirstResponder()
            }
        default: break
        }
        return false
    }

    private func makeURLTextFieldFirstResponder() -> Bool {
        if urlTextField?.acceptsFirstResponder == true {
            return view.window?.makeFirstResponder(urlTextField) == true
        }
        return false
    }

    private func startObservingURL() {
        webViewURLObserver = webView.observe(\.url) { (webView, _) in

            if let newURL = webView.url?.massagedURL() {
                webView.stopLoading()
                self.browserAction = .visit(url: newURL)
                return
            }

            switch self.browserAction {
            case .visit, .search:
                self.toolbar?.urlTextField.stringValue = webView.url?.absoluteString ?? ""
            default: break
            }
        }
    }

    private func presentErrorWebPage(title: String, message: String) {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "error", ofType: "html") else {
            print("couldn't find path for error.html")
            return
        }
        let isDarkMode = NSAppearance.isDarkMode(UserDefaults.standard)
        var html: String = ErrorHandler.shared.wrap { try String(contentsOfFile: path) } ?? ""
        html = html.replacingOccurrences(of: "{{title}}", with: title)
        html = html.replacingOccurrences(of: "{{message}}", with: message)
        html = html.replacingOccurrences(of: "{{bg-rgb}}", with: isDarkMode ? "30" : "246")
        html = html.replacingOccurrences(of: "{{bg-rgb}}", with: isDarkMode ? "rgb(110, 110, 110);" : "")
        self.html = html
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
        Log.error(error)
        switch abs(error._code) {
        case 102, 999: // TODO: create enum of error codes & decide which should be shown to user
            return
        default :
            browserAction = .showError(title: "Floaty couldn't load the URL", message: error.localizedDescription)
        }
    }
}
