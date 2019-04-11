//
//  Settings.swift
//  Floaty
//
//  Created by James Zaghini on 11/6/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Cocoa

class Settings: Codable {

    var storeFilename = ""

    var homepageURLString: String {
        didSet { save() }
    }

    var windowOpacityObservable = Observable(CGFloat?(nil))
    var windowOpacity: CGFloat {
        didSet {
            Log.info("windowOpacity: \(windowOpacity)")
            windowOpacityObservable.value = windowOpacity
            save()
        }
    }

    private enum CodingKeys: String, CodingKey {
        case homepageURLString, windowOpacity
    }

    static func load(storeFilename: String) -> Settings {
        if Storage.fileExists(storeFilename), let settings = Storage.retrieve(storeFilename, as: Settings.self) {
            settings.storeFilename = storeFilename
            return settings
        }
        let settings = Settings(storeFilename: storeFilename)
        settings.windowOpacityObservable.value = settings.windowOpacity
        return settings
    }

    // MARK: - Private

    init(storeFilename: String,
         homepageURLString: String = "https://www.duckduckgo.com?kae=d",
         windowOpacity: CGFloat = 1) {
        self.homepageURLString = homepageURLString
        self.windowOpacity = windowOpacity
        self.storeFilename = storeFilename
        save()
    }

    private func save() {
        Storage.store(self, as: storeFilename)
    }

}
