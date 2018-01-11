//
//  Printable.swift
//  mgen
//
//  Created by Vladimir Shutov on 10.01.2018.
//  Copyright © 2018 smd. All rights reserved.
//

import Foundation

protocol Printable {
    func writeMessage(_ message: String, to stream: OutputType)
}

extension Printable {
    func writeMessage(_ message: String, to stream: OutputType = .standard) {
        switch stream {
        case .standard:
            fputs(message, stdout)
        case .error:
            fputs("Error: \(message)\n", stderr)
        }
    }
}
