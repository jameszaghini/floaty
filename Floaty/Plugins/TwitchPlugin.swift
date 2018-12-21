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

    func massageURL(_ url: URL) -> URL {
        guard hostnames.contains(url.host ?? "") else { return url }
        let newURLString = url.absoluteString.replacingOccurrences(of: "https://twitch.tv/videos/", with: "https://player.twitch.tv/?video=v")
        return URL(string: newURLString) ?? url
    }
}
