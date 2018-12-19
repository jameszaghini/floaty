//
//  SearchProvider.swift
//  Floaty
//
//  Created by James Zaghini on 17/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Foundation

protocol SearchProvider {
    var url: URL { get }
}

struct Google: SearchProvider {
    var url = URL(string: "https://www.google.com")!
}

struct DuckDuckGo: SearchProvider {
    var url = URL(string: "https://www.duckduckgo.com?kae=d")!
}
