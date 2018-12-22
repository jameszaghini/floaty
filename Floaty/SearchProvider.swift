//
//  SearchProvider.swift
//  Floaty
//
//  Created by James Zaghini on 17/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Foundation

typealias SearchProviderId = String

protocol SearchProvider {
    var providerId: SearchProviderId { get }
    var url: URL { get }
    var searchURLString: String { get }
}

struct Search {
    static let allProviders: [SearchProvider] = [DuckDuckGo(), Google()]
    static let defaultProvider: SearchProvider = {
        return allProviders.first!
    }()

    static func activeProvider(settings: Settings) -> SearchProvider {
        return allProviders.filter { $0.providerId == settings.searchProviderId }.first ?? Search.defaultProvider
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
