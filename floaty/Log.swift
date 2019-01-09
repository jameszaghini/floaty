//
//  Log.swift
//  Floaty
//
//  Created by James Zaghini on 25/12/18.
//  Copyright © 2018 James Zaghini. All rights reserved.
//

import CocoaLumberjack

struct Log {
    static func setup() {
        DDLog.add(DDOSLogger.sharedInstance)
    }
}
