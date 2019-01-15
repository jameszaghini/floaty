//
//  BrowserAction.swift
//  Floaty
//
//  Created by James Zaghini on 6/1/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import Foundation

enum BrowserAction: Equatable {
    case search(text: String)
    case visit(url: URL?)
    case showError(title: String, message: String)
    case none
}
