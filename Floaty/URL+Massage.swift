//
//  URL+Massage.swift
//  Floaty
//
//  Created by James Zaghini on 20/5/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Foundation

struct SiteEnhancement {
    var userAgentString: String?
}

extension URL {

    func massagedURL() -> URL {
        var urlString = absoluteString

        if !urlString.hasPrefix("http://") && !urlString.hasPrefix("https://") {
            urlString = "https://" + urlString
        }

        urlString = urlString.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "https://www.youtube.com/embed/")

        let massagedURL = URL(string: urlString)
        return massagedURL ?? self
    }
}
