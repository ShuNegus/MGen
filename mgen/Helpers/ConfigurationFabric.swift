//
//  ConfigurationFabric.swift
//  mgen
//
//  Created by Vladimir Shutov on 16.01.2018.
//  Copyright © 2018 smd. All rights reserved.
//

import Foundation

class ConfigurationFabric {
    
    var creater: String {
        get {
            return configuration?[kCreater] ?? Config.defaultCreater
        }
        set {
            var newConfiguration = configuration
            newConfiguration?[kCreater] = newValue
            configuration = newConfiguration
        }
    }
    
    var copyright: String {
        get {
            return configuration?[kCopyright] ?? Config.defaultCopyright
        }
        set {
            var newConfiguration = configuration
            newConfiguration?[kCopyright] = newValue
            configuration = newConfiguration
        }
    }
    
    
    private let kCreater = "kCreater"
    private let kCopyright = "kCopyright"
    
    private var configuration: [String: String]? {
        get {
            let confFilePath = DirectoryFabric().utilityDirectoryPath.appendingPathComponent("conf.plist")
            if let nsConfiguration = NSDictionary(contentsOfFile: confFilePath.path),
                let configuration = nsConfiguration as? [String: String] {
                return configuration
            } else {
                return nil
            }
        }
        set {
            let configuration = newValue as NSDictionary?
            let confFilePath = DirectoryFabric().utilityDirectoryPath.appendingPathComponent("conf.plist")
            configuration?.write(toFile: confFilePath.path, atomically: true)
        }
    }
}
