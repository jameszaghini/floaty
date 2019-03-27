//
//  Log.swift
//  Floaty
//
//  Created by James Zaghini on 10/1/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

class Log {
    static func info(_ string: String) {
        print("--I: " + string)
    }
    static func error(_ error: Error, additionalInfo: String? = nil) {
        print("--E: code: \(error._code), description: \(error.localizedDescription). \(additionalInfo ?? "")")
    }
}
