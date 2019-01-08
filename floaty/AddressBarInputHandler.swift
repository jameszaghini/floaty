//
//  AddressBarInputHandler.swift
//  Floaty
//
//  Created by James Zaghini on 5/1/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import Foundation
import CocoaLumberjack

struct AddressBarInputHandler {

    // Note, a single word returns a URL from URL(string: )
    // But we want to search if the text is a single word :\
    static func actionFromEnteredText(_ text: String) -> BrowserAction {

        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .none
        }

        var action: BrowserAction?

        if let url = URL(string: text), parseHost(url) != nil {
            if url.scheme != nil {
                action = .visit(url: url)
            } else if let adjustedURL = URL(string: "https://" + text) {
                action = .visit(url: adjustedURL)
            }
        }

        return action ?? .search(text: text)
    }

    static func parseHost(_ url: URL) -> ParsedHost? {
        do {
            let parser = try DomainParser()
            let urlParsedHost = parser.parse(host: url.host ?? "")
            let prefixedURL = URL(string: "https://" + url.absoluteString)
            let prefixedURLParsedHost = parser.parse(host: prefixedURL?.host ?? "")
            return urlParsedHost ?? prefixedURLParsedHost
        } catch let error {
            DDLogError(error.localizedDescription)
            return nil
        }
    }

}
