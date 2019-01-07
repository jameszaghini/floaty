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

    var replace: [String: String] = [
        "https://www.youtube.com/watch?v=": "https://www.youtube.com/embed/",
    ]
}
