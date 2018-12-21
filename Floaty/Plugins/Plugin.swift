//
//  Plugin.swift
//  Floaty
//
//  Created by James Zaghini on 21/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import Foundation

typealias ParameterKey = String
typealias ParameterValue = String

protocol Plugin {
    var name: String { get }
    var hostnames: [String] { get }
    var additionalQueryParams: DictionaryLiteral<ParameterKey, ParameterValue> { get }
    func massageURL(_ url: URL) -> URL
}
