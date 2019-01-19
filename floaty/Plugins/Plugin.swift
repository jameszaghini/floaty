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
        guard hostnames.contains(url.host ?? "") else {
            Log.info("Plugin \(name) doesn't contain host" + (url.host ?? ""))
            return url
        }
        Log.info("Plugin \(name) DOES contain host" + (url.host ?? ""))

        var url = url
        url = doReplace(url: url)
        url = addAdditionalParams(url: url)
        return url
    }

    func doReplace(url: URL) -> URL {
        var newURLString = url.absoluteString

        replace.forEach {
            newURLString = newURLString.replacingOccurrences(of: $0, with: $1)
        }

        return URL(string: newURLString) ?? url
    }

    func addAdditionalParams(url: URL) -> URL {
        guard !additionalQueryParams.isEmpty else { return url }
        var urlString = url.absoluteString

        if url.query == nil {
            urlString += "?"
        }

        additionalQueryParams.forEach { (key: ParameterKey, value: ParameterValue) in
            if !url.containsParameterKey(key) {
                urlString.append("\(key)=\(value)&")
            }
        }
        urlString = String(urlString.dropLast())

        return URL(string: urlString) ?? url
    }
}
