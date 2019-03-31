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

    var windowOpacityObservable = Observable(CGFloat(1))
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
        if Storage.fileExists(storeFilename, in: .documents) {
            var settings =  Storage.retrieve(storeFilename, from: .documents, as: Settings.self)
            settings.storeFilename = storeFilename
            return settings
        }
        let settings = Settings(storeFilename: storeFilename)
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
        Storage.store(self, to: .documents, as: storeFilename)
    }

}
