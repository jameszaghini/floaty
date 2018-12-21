//
//  VimeoPlugin.swift
//  Floaty
//
//  Created by James Zaghini on 21/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Foundation

struct VimeoPlugin: Plugin {
    var name = "Vimeo"

    var hostnames = ["www.vimeo.com", "vimeo.com"]

    // https://help.vimeo.com/hc/en-us/articles/360001494447-Using-Player-Parameters
    var additionalQueryParams: DictionaryLiteral<ParameterKey, ParameterValue> = [
        "transparent": "0",
        "autoplay": "1",
    ]

    func massageURL(_ url: URL) -> URL {
        guard hostnames.contains(url.host ?? "") else { return url }
        let newURLString = url.absoluteString.replacingOccurrences(of: "https://vimeo.com/", with: "https://player.vimeo.com/video/")
        return URL(string: newURLString) ?? url
    }
}
