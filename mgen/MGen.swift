//
//  MGen.swift
//  mgen
//
//  Created by Vladimir Shutov on 10.01.2018.
//  Copyright © 2018 smd. All rights reserved.
//

import Foundation

class MGen: Printable {
    
    func startWithArguments(_ arguments: [String]) {
        var value: String?
        var printCommand: PrintCommand?
        var patternCommand: PatternCommand?
        var configurationCommand: ConfigurationCommand?
        
        for argument in arguments {
            if let _printCommand = PrintCommand(rawValue: argument), printCommand == nil {
                printCommand = _printCommand
            } else if let _patternCommand = PatternCommand(rawValue: argument), patternCommand == nil {
                patternCommand = _patternCommand
            } else if let _configurationCommand = ConfigurationCommand(rawValue: argument), configurationCommand == nil {
                configurationCommand = _configurationCommand
            } else if value == nil {
                value = argument
            } else {
                writeMessage(Localization.inputError, to: .error)
            }
        }
        
        if let printCommand = printCommand {
            workWithPrinCommand(printCommand)
        }
        
        if let patternCommand = patternCommand, let moduleName = value {
            workWithPatternCommand(patternCommand, moduleName: moduleName)
        }
        
        if let configurationCommand = configurationCommand, let configurationValue = value {
            updateConfiguration(configurationCommand, value: configurationValue)
        }
        
        writeMessage(Localization.inputError, to: .error)
        exit(EXIT_FAILURE)
    }
    
    private func workWithPrinCommand(_ command: PrintCommand) {
        switch command {
        case .about:
            writeMessage(Localization.about)
        case .help:
            writeMessage(Localization.help)
        case .version:
            writeMessage(Localization.version)
        }
        exit(EXIT_SUCCESS)
    }
    
    private func workWithPatternCommand(_ command: PatternCommand, moduleName: String) {
        let fileManager = FileManager.default
        let directoryFabric = DirectoryFabric()
        let templateDirectoryPath = directoryFabric.templateDirectoryPath.appendingPathComponent(command.directory)
        let currentDirectoryPath = URL(fileURLWithPath: fileManager.currentDirectoryPath).appendingPathComponent(moduleName + "Module")
        guard fileManager.fileExists(atPath: templateDirectoryPath.path) else {
            writeMessage(templateDirectoryPath.path + " " + Localization.templateDirectoryError, to: .error)
            return
        }
        
        do {
            try fileManager.createDirectory(at: currentDirectoryPath, withIntermediateDirectories: false, attributes: nil)
        } catch let error {
            writeMessage(error.localizedDescription, to: .error)
            exit(EXIT_FAILURE)
        }
        
        let dateNow = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.string(from: dateNow)
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: dateNow)
        let configurationFabric = ConfigurationFabric()
        let creater = configurationFabric.creater
        let copyright = configurationFabric.copyright
        
        let fileEnumerator = fileManager.enumerator(at: templateDirectoryPath, includingPropertiesForKeys: nil, options: .skipsHiddenFiles, errorHandler: nil)
        while let element = fileEnumerator?.nextObject() as? URL {
            var isDirectory: ObjCBool = true
            if fileManager.fileExists(atPath: element.path, isDirectory: &isDirectory) {
                
                do {
                    guard !isDirectory.boolValue else {
                        let newPath = element.path.replacingOccurrences(of: templateDirectoryPath.path + "/", with: "")
                        let modulePath = newPath.replacingOccurrences(of: "%MODULENAME%", with: moduleName)
                        let resultPath = currentDirectoryPath.appendingPathComponent(modulePath)
                        try fileManager.createDirectory(at: resultPath, withIntermediateDirectories: false, attributes: nil)
                        continue
                    }
                    
                    if let fileContent = try? String(contentsOf: element) {
                        // Setup file
                        var resultFile = fileContent.replacingOccurrences(of: TemplateKeys.kCreater, with: creater)
                        resultFile = resultFile.replacingOccurrences(of: TemplateKeys.kCopyright, with: year + " " + copyright)
                        resultFile = resultFile.replacingOccurrences(of: TemplateKeys.kDate, with: date)
                        resultFile = resultFile.replacingOccurrences(of: "%MODULENAME%", with: moduleName)
                        let fileName = element.lastPathComponent
                        let filePath = element.path.replacingOccurrences(of: fileName, with: fileName.replacingOccurrences(of: "%MODULENAME%", with: moduleName))
                        let newPath = filePath.replacingOccurrences(of: templateDirectoryPath.path + "/", with: "")
                        let resultPath = currentDirectoryPath.appendingPathComponent(newPath)
                        try resultFile.write(to: resultPath, atomically: true, encoding: .utf8)
                    } else {
                        let newPath = element.path.replacingOccurrences(of: templateDirectoryPath.path + "/", with: "")
                        let resultPath = currentDirectoryPath.appendingPathComponent(newPath)
                        try fileManager.copyItem(at: element, to: resultPath)
                    }
                    
                } catch let error {
                    writeMessage(error.localizedDescription, to: .error)
                    exit(EXIT_FAILURE)
                }
                
            }
        }
    }
    
    private func updateConfiguration(_ command: ConfigurationCommand, value: String) {
        let configurationFabric = ConfigurationFabric()
        switch command {
        case .copyright:
            configurationFabric.copyright = value
        case .creater:
            configurationFabric.creater = value
        }
    }
    
}
