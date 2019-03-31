//
//  SearchProvider.swift
//  Floaty
//
//  Created by James Zaghini on 17/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Foundation

typealias SearchProviderId = String

protocol SearchProvider: Codable {
    var providerId: SearchProviderId { get }
    var url: URL { get }
    var searchURLString: String { get }
}

struct Search {

    static let duckDuckGo = DuckDuckGo()
    static let google = Google()
    static let bing = Bing()

    static let allProviders: [SearchProvider] = [duckDuckGo, google, bing]
    static let defaultProvider: SearchProvider = duckDuckGo

    static func activeProvider(settings: Settings) -> SearchProvider {
        return defaultProvider
    }
}

struct Google: SearchProvider {
    let providerId = "google"
    var url = URL(string: "https://www.google.com")!
    var searchURLString = "https://google.com/search?client=safari&q="
}

struct DuckDuckGo: SearchProvider {
    let providerId = "duckduckgo"
    var url = URL(string: "https://www.duckduckgo.com?kae=d")!
    var searchURLString = "https://duckduckgo.com/?q="
}

struct Bing: SearchProvider {
    let providerId = "bing"
    var url = URL(string: "https://www.bing.com/")!
    var searchURLString = "https://www.bing.com/search?q="
}
