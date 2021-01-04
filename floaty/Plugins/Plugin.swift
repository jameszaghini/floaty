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
    var additionalQueryParams: KeyValuePairs<ParameterKey, ParameterValue> { get }
    var replace: [String: String] { get }
    func massageURL(_ url: URL) -> URL?
}

extension Plugin {

    func doReplace(url: URL) -> URL? {
        var newURLString = url.absoluteString

        for (find, rep) in replace {
            if newURLString.contains(find) {
                Log.info("Relpacing: \(find), with:\(rep)")
                newURLString = newURLString.replacingOccurrences(of: find, with: rep)
            }
        }

        return newURLString != url.absoluteString ? URL(string: newURLString) : nil
    }

    func addAdditionalParams(url: URL) -> URL {
        guard !additionalQueryParams.isEmpty else { return url }
        var urlString = url.absoluteString

        if url.query == nil {
            urlString += "?"
        }

        additionalQueryParams.forEach { (key: ParameterKey, value: ParameterValue) in
            if !url.containsParameterKey(key) {
                Log.info("Appending: \(key), with:\(value)")
                urlString.append("\(key)=\(value)&")
            }
        }
        urlString = String(urlString.dropLast())

        return URL(string: urlString) ?? url
    }
}
