//
//  TwitchPlugin.swift
//  Floaty
//
//  Created by James Zaghini on 22/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Foundation

struct TwitchPlugin: Plugin {

    var name = "Twitch"

    var hostnames = ["www.twitch.tv", "twitch.tv"]

    var additionalQueryParams: DictionaryLiteral<ParameterKey, ParameterValue> = [:]

    var replace: [String: String] = [
        "https://twitch.tv/videos/": "https://player.twitch.tv/?video=v",
    ]

    func massageURL(_ url: URL) -> URL? {
        guard hostnames.contains(url.host ?? "") else { return nil }
        Log.info("Plugin \(name) DOES contain host: " + (url.host ?? ""))

        if let newURL = doReplace(url: url) {
            let url = addAdditionalParams(url: newURL)
            return url

        }
        return nil
    }
}
