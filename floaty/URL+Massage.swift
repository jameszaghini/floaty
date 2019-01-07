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
        var massagedURL = URL(string: absoluteString)
        Services.shared.settings.plugins.forEach { plugin in
            massagedURL = plugin.massageURL(massagedURL ?? self)
        }

        return massagedURL ?? self
    }
}
