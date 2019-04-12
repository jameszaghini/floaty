//
//  AddressBarInputHandler.swift
//  Floaty
//
//  Created by James Zaghini on 5/1/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import Foundation

struct AddressBarInputHandler {

    static private var domainParser: DomainParser? = {
        return try? DomainParser()
    }()

    // Note, a single word returns a URL from URL(string: )
    // But we want to search if the text is a single word :\
    static func actionFromEnteredText(_ text: String) -> BrowserAction {

        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .none
        }

        guard let url = URL(string: text) else {
            return .search(text: text)
        }

        var action: BrowserAction?

        if canVisitURL(url, text: text) {
            if url.scheme != nil {
                action = .visit(url: url)
            } else if let adjustedURL = URL(string: "https://" + text) {
                action = .visit(url: adjustedURL)
            }
        }

        return action ?? .search(text: text)
    }

    static func canVisitURL(_ url: URL, text: String) -> Bool {
        return parseHost(url)?.publicSuffix != nil &&
            parseHost(url)?.domain != nil ||
            isValidIPAddress(url) ||
            isLoopbackAddress(text)
    }

    static func parseHost(_ url: URL) -> ParsedHost? {
        guard let parser = domainParser else { return nil }
        let urlParsedHost = parser.parse(host: url.host ?? "")
        let prefixedURL = URL(string: "https://" + url.absoluteString)
        let prefixedURLParsedHost = parser.parse(host: prefixedURL?.host ?? "")
        return urlParsedHost ?? prefixedURLParsedHost
    }

    static func isValidIPAddress(_ url: URL) -> Bool {
        guard let host = url.host else { return false }
        return host.split(separator: ".")
                   .compactMap { Int($0) }
                   .filter { 0..<255 ~= $0 }
                   .count == 4

    }

    static func isLoopbackAddress(_ text: String) -> Bool {
        return text.hasPrefix("http://localhost") || text.hasPrefix("https://localhost")
    }

}
