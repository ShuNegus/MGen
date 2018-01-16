//
//  ConfigurationCommand.swift
//  mgen
//
//  Created by Vladimir Shutov on 16.01.2018.
//  Copyright © 2018 smd. All rights reserved.
//

import Foundation

enum ConfigurationCommand {
    case creater
    case copyright
    
    init?(rawValue: String) {
        switch rawValue {
        case "-creater":
            self = .creater
        case "-copyright":
            self = .copyright
        default:
            return nil
        }
    }
}
