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

    var hostnames = ["www.youtube.com", "www.youtu.be", "youtu.be"]

    // https://www.youtube.com/watch?v=4xUQD2CanuY&feature=youtu.be
    // https://www.youtube.com/watch?time_continue=36&v=mNDA-o9yJNw
    var additionalQueryParams: KeyValuePairs<ParameterKey, ParameterValue> = [
        "autoplay": "1",
        "modestbranding": "1",
        "fs": "0",
    ]

    var replace: [String: String] = [
        "https://www.youtube.com/watch?v=": "https://www.youtube.com/embed/",
        "http://youtu.be/": "https://www.youtube.com/embed/",
        "https://youtu.be/": "https://www.youtube.com/embed/",
    ]

    // TODO: append all other query string values, like start time
    func massageURL(_ url: URL) -> URL? {

        let prefix = "https://www.youtube.com/embed/"

        // if it's already an embed url, nothing more to do
        guard !url.absoluteString.hasPrefix(prefix) else {
            return nil
        }

        var newURLString: String?

        if let videoId = url["v"] {
            newURLString = prefix + videoId
        } else if url.absoluteString.hasPrefix("http://youtu.be/") {
            newURLString = url.absoluteString.replacingOccurrences(of: "http://youtu.be/", with: prefix)
        } else if url.absoluteString.hasPrefix("https://youtu.be/") {
            newURLString = url.absoluteString.replacingOccurrences(of: "https://youtu.be/", with: prefix)
        }

        if let newURLString = newURLString {
            var string = newURLString
            string += "?"
            string += "modestbranding=1&"
            string += "autoplay=1&"
            string += "fs=0"
            return URL(string: string)
        }

        return nil
    }
}
