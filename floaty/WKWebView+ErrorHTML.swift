//
//  WKWebView+ErrorHTML.swift
//  Floaty
//
//  Created by James Zaghini on 9/1/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import WebKit

extension WKWebView {

    func presentAnError(title: String, message: String) {
        guard let path = Bundle.main.path(forResource: "error", ofType: "html") else { return }
        var html: String = ErrorHandler.shared.wrap { try String(contentsOfFile: path) } ?? ""
        html = html.replacingOccurrences(of: "{{title}}", with: title)
        html = html.replacingOccurrences(of: "{{message}}", with: message)

        var isDarkMode: Bool {
            let mode = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
            return mode == "Dark"
        }

        html = html.replacingOccurrences(of: "{{bg-rgb}}", with: isDarkMode ? "30" : "246")
        html = html.replacingOccurrences(of: "{{bg-rgb}}", with: isDarkMode ? "rgb(110, 110, 110);" : "")
        loadHTMLString(html, baseURL: Bundle.main.bundleURL)
    }

}
