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

    // Note, a single word returns a URL from URL(string
    // But we want to search if the text is a single word :\
    static func actionFromEnteredText(_ text: String) -> BrowserAction {

        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .none
        }

        guard let url = URL(string: text) else {
            return .search(text: text)
        }

        do {
            let parser = try DomainParser()
            let urlParsedHost = parser.parse(host: url.host ?? "")
            let prefixedURL = URL(string: "https://" + url.absoluteString)
            let prefixedURLParsedHost = parser.parse(host: prefixedURL?.host ?? "")
            if urlParsedHost == nil && prefixedURLParsedHost == nil {
                return .search(text: text)
            }
        } catch let error {
            DDLogError(error.localizedDescription)
            return .search(text: text)
        }

        if url.scheme != nil {
            return .visit(url: url)
        }

        let adjustedURL = URL(string: "https://" + text)!
        return .visit(url: adjustedURL)
    }

}
