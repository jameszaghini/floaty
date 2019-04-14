//
//  MockUserDefaults.swift
//  Floaty
//
//  Created by James Zaghini on 3/4/19.
//  Copyright © 2019 James Zaghini. All rights reserved.
//

import Foundation

class MockUserDefaults: UserDefaults {

    convenience init() {
        self.init(suiteName: "tests")!
    }

    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)
        super.init(suiteName: suitename)
    }

}
