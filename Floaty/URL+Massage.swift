//
//  URL+Massage.swift
//  Floaty
//
//  Created by James Zaghini on 20/5/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Foundation

extension URL {

    func containsParameterKey(_ key: ParameterKey) -> Bool {
        return URLComponents(string: absoluteString)?.queryItems?.first(where: { $0.name == key }) != nil
    }

    func massagedURL() -> URL {
        var urlString = absoluteString

        if !urlString.hasPrefix("http://") && !urlString.hasPrefix("https://") {
            urlString = "https://" + urlString
        }

        var massagedURL: URL?
        Services.shared.settings.plugins.forEach { plugin in
            massagedURL = plugin.massageURL(URL(string: urlString)!)
        }

        return massagedURL ?? self
    }
}
