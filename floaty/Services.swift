//
//  Services.swift
//  Floaty
//
//  Created by James Zaghini on 11/6/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

struct Services {
    static let shared = Services()
    var settings = Settings.load()
}

protocol Serviceable {
    var services: Services { get }
}

extension Serviceable {
    var services: Services { return Services.shared }
}
