//
//  Settings.swift
//  Floaty
//
//  Created by James Zaghini on 11/6/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa
import Observable

struct Settings: Codable {

    private var defaults: UserDefaults = UserDefaults.standard
    private static let defaultsKey = "settings"

    var homepageURL: String {
        didSet { save() }
    }

    var windowOpacityObservable = Observable(CGFloat(1))
    var windowOpacity: CGFloat {
        didSet {
            windowOpacityObservable.value = windowOpacity
            save()
        }
    }

    var plugins: [Plugin] = [YoutubePlugin(), VimeoPlugin(), TwitchPlugin()]

    var searchProviderId: SearchProviderId {
        didSet { save() }
    }

    private enum CodingKeys: String, CodingKey {
        case homepageURL, windowOpacity, searchProviderId
    }

    static func load(defaults: UserDefaults = UserDefaults.standard) -> Settings {
        guard let data = defaults.value(forKey: defaultsKey) as? Data else {
            return Settings()
        }
        var settings = try? JSONDecoder().decode(Settings.self, from: data)
        settings?.defaults = defaults
        return settings ?? Settings()
    }

    // MARK: - Private

    private init(homepageURL: String = "https://www.duckduckgo.com?kae=d",
                 windowOpacity: CGFloat = 1,
                 searchProviderId: SearchProviderId = Search.defaultProvider.providerId,
                 defaults: UserDefaults = UserDefaults.standard) {
        self.homepageURL = homepageURL
        self.windowOpacity = windowOpacity
        self.searchProviderId = searchProviderId
        self.defaults = defaults
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            defaults.set(encoded, forKey: Settings.defaultsKey)
        }
    }
}
