//
//  Storage.swift
//  Floaty
//
//  Created by James Zaghini on 30/3/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

// Based on:
// https://medium.com/@sdrzn/swift-4-codable-lets-make-things-even-easier-c793b6cf29e1
// https://gist.github.com/saoudrizwan/b7ab1febde724c6f30d8a555ea779140

import Foundation

public class Storage {

    fileprivate init() { }

    static private var applicationSupportURL: URL? {
        guard let bundleId = Bundle.main.bundleIdentifier else { return nil }
        var applicationSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        applicationSupportURL?.appendPathComponent(bundleId)
        return applicationSupportURL
    }

    private static func createApplicationSupportDirectoryIfRequired() {
        guard let url = Storage.applicationSupportURL else { return }
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
    }

    static func store<T: Encodable>(_ object: T, as fileName: String) {
        createApplicationSupportDirectoryIfRequired()
        guard let url = applicationSupportURL?.appendingPathComponent(fileName, isDirectory: false) else { return }
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    static func retrieve<T: Decodable>(_ fileName: String, as type: T.Type) -> T? {
        guard let url = applicationSupportURL?.appendingPathComponent(fileName, isDirectory: false) else { return nil }

        if !FileManager.default.fileExists(atPath: url.path) {
            return nil
        }

        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("No data at \(url.path)!")
        }
    }

    static func remove(_ fileName: String) {
        guard let url = applicationSupportURL?.appendingPathComponent(fileName, isDirectory: false) else { return }
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    static func fileExists(_ fileName: String) -> Bool {
        guard let url = applicationSupportURL?.appendingPathComponent(fileName, isDirectory: false) else { return false }
        return FileManager.default.fileExists(atPath: url.path)
    }
}
