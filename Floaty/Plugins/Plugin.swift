//
//  Plugin.swift
//  Floaty
//
//  Created by James Zaghini on 21/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Foundation

typealias ParameterKey = String
typealias ParameterValue = String

protocol Plugin {
    var name: String { get }
    var hostnames: [String] { get }
    var additionalQueryParams: DictionaryLiteral<ParameterKey, ParameterValue> { get }
    var replace: [String: String] { get }
    func massageURL(_ url: URL) -> URL
}

extension Plugin {

    func massageURL(_ url: URL) -> URL {
        guard hostnames.contains(url.host ?? "") else { return url }

        var newURLString = url.absoluteString

        replace.forEach {
            newURLString = url.absoluteString.replacingOccurrences(of: $0, with: $1)
        }

        guard let newURL = URL(string: newURLString) else { return url }

        if !additionalQueryParams.isEmpty {
            if newURL.query == nil {
                newURLString += "?"
            }

            additionalQueryParams.forEach { (key: ParameterKey, value: ParameterValue) in
                if !newURL.containsParameterKey(key) {
                    newURLString.append("\(key)=\(value)&")
                }
            }
            newURLString = String(newURLString.dropLast())
        }

        return URL(string: newURLString) ?? url
    }

}
