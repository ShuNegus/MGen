//
//  Config.swift
//  mgen
//
//  Created by Vladimir Shutov on 11.01.2018.
//  Copyright © 2018 smd. All rights reserved.
//

import Foundation

class Config {
    static let version = "0.1"
    static let defaultCreater = "MGen"
    static let defaultCopyright = "IOS Developer"
}


enum TemplateKeys {
    static let kCreater = "%CREATER%"
    static let kCopyright = "%COPYRIGHT%"
    static let kDate = "%DATE%"
}
