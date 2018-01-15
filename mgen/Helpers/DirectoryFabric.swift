//
//  DirectoryFabric.swift
//  mgen
//
//  Created by Vladimir Shutov on 15.01.2018.
//  Copyright © 2018 smd. All rights reserved.
//

import Foundation

class DirectoryFabric {
    
    var utilityDirectoryPath: URL {
        return homeDirectory.appendingPathComponent(utilityDirectory)
    }
    
    var templateDirectoryPath: URL {
        return utilityDirectoryPath.appendingPathComponent(templateDirectory)
    }
    
    private let utilityDirectory = ".mgen"
    private let templateDirectory = "Templates"
    private let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
}
