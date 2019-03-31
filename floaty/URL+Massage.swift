//
//  URL+Massage.swift
//  Floaty
//
//  Created by James Zaghini on 20/5/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Foundation

extension URL {

    subscript(queryParam: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParam })?.value
    }

    func containsParameterKey(_ key: ParameterKey) -> Bool {
        return URLComponents(string: absoluteString)?.queryItems?.first(where: { $0.name == key }) != nil
    }

    func massagedURL() -> URL? {
        var newURL: URL?
        for plugin in Services.shared.activePlugins {
            if let massaged = plugin.massageURL(self) {
                newURL = massaged
                break
            }
        }
        return newURL
    }
}
