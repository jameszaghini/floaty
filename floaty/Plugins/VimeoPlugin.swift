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

    var replace: [String: String] = [
        "https://vimeo.com/": "https://player.vimeo.com/video/",
    ]
}
