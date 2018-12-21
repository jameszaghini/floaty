//
//  YoutubePlugin.swift
//  Floaty
//
//  Created by James Zaghini on 21/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Foundation

struct YoutubePlugin: Plugin {
    var name = "Youtube"

    var hostnames = ["www.youtube.com", "www.youtu.be"]

    // https://www.youtube.com/watch?v=4xUQD2CanuY&feature=youtu.be
    var additionalQueryParams: DictionaryLiteral<ParameterKey, ParameterValue> = [
        "autoplay": "1",
        "modestbranding": "1",
        "fs": "0",
    ]

    func massageURL(_ url: URL) -> URL {

        guard hostnames.contains(url.host ?? "") else { return url }

        let target = "https://www.youtube.com/watch?v="
        guard url.absoluteString.contains(target) else { return url }

        var newURLString = url.absoluteString.replacingOccurrences(of: target, with: "https://www.youtube.com/embed/")

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
