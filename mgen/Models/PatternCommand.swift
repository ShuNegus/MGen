//
//  PatternCommand.swift
//  mgen
//
//  Created by Vladimir Shutov on 15.01.2018.
//  Copyright © 2018 smd. All rights reserved.
//

import Foundation

enum PatternCommand {
    
    case mvp
    case mvvm
    case custom
    
    var directory: String {
        switch self {
        case .mvp:
            return "MVP"
        case .mvvm:
            return "MVVM"
        case .custom:
            return "CUSTOM"
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "-mvp":
            self = .mvp
        case "-mvvm":
            self = .mvvm
        case "-custom":
            self = .custom
        default:
            return nil
        }
    }
}
