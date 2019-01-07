//
//  String+Conveniences.swift
//  Floaty
//
//  Created by James Zaghini on 6/1/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import Foundation

extension String {
    var containsWhitespace: Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
}
