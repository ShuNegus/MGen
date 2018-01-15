//
//  PrintCommand.swift
//  mgen
//
//  Created by Vladimir Shutov on 15.01.2018.
//  Copyright © 2018 smd. All rights reserved.
//

import Foundation

enum PrintCommand {
    
    case about
    case version
    case help
    
    init?(rawValue: String) {
        switch rawValue {
        case "--about", "-a":
            self = .about
        case "--version", "-v":
            self = .version
        case "--help", "-h":
            self = .help
        default:
            return nil
        }
    }
}
