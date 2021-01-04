//
//  SearchProvider.swift
//  Floaty
//
//  Created by James Zaghini on 17/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Foundation

typealias SearchProviderId = String
typealias SearchProviderName = String

protocol SearchProvider: Codable {
    var identifier: SearchProviderId { get }
    var name: SearchProviderName { get }
    var url: URL { get }
    var searchURLString: String { get }
}

struct Search {
    static let duckDuckGo = DuckDuckGo()
    static let google = Google()
    static let bing = Bing()

    static let allProviders: [SearchProvider] = [duckDuckGo, google, bing]
    static let defaultProvider: SearchProvider = duckDuckGo

    static func activeProvider(withId identifier: SearchProviderId) -> SearchProvider {
        return Search.allProviders.first(where: {
            $0.identifier == identifier
        }) ?? Search.defaultProvider
    }
}

struct Google: SearchProvider {
    var identifier = "google"
    var name = "Google"
    var url = URL(string: "https://www.google.com")!
    var searchURLString = "https://google.com/search?client=safari&q="
}

struct DuckDuckGo: SearchProvider {
    var identifier = "duckduckgo"
    var name = "DuckDuckGo"
    var url = URL(string: "https://www.duckduckgo.com?kae=d")!
    var searchURLString = "https://www.duckduckgo.com?kae=d&q="
}

struct Bing: SearchProvider {
    var identifier = "bing"
    var name = "Bing"
    var url = URL(string: "https://www.bing.com/")!
    var searchURLString = "https://www.bing.com/search?q="
}
