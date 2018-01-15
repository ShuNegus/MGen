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
        var moduleName: String?
        var printCommand: PrintCommand?
        var patternCommand: PatternCommand?
        
        for argument in arguments {
            if let _printCommand = PrintCommand(rawValue: argument), printCommand == nil {
                printCommand = _printCommand
            } else if let _patternCommand = PatternCommand(rawValue: argument), patternCommand == nil {
                patternCommand = _patternCommand
            } else if moduleName == nil {
                moduleName = argument
            } else {
                writeMessage(Localization.inputError, to: .error)
            }
        }
        
        if let printCommand = printCommand {
            workWithPrinCommand(printCommand)
        }
        
        if let patternCommand = patternCommand, let moduleName = moduleName {
            workWithPatternCommand(patternCommand, moduleName: moduleName)
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
        
        let fileEnumerator = fileManager.enumerator(at: templateDirectoryPath, includingPropertiesForKeys: nil, options: .skipsHiddenFiles, errorHandler: nil)
        while let element = fileEnumerator?.nextObject() as? URL {
            var isDirectory: ObjCBool = true
            if fileManager.fileExists(atPath: element.path, isDirectory: &isDirectory) {
                
                do {
                    guard !isDirectory.boolValue else {
                        let newPath = element.path.replacingOccurrences(of: templateDirectoryPath.path + "/", with: "")
                        let resultPath = currentDirectoryPath.appendingPathComponent(newPath)
                        try fileManager.createDirectory(at: resultPath, withIntermediateDirectories: false, attributes: nil)
                        continue
                    }
                    
                    if let fileContent = try? String(contentsOf: element) {
                        // Setup file
                        var resultFile = fileContent.replacingOccurrences(of: TemplateKeys.kCreater, with: "")
                        resultFile = resultFile.replacingOccurrences(of: TemplateKeys.kCopyright, with: year + " " + "")
                        resultFile = resultFile.replacingOccurrences(of: TemplateKeys.kDate, with: date)
                        let fileName = element.lastPathComponent
                        let filePath = element.path.replacingOccurrences(of: fileName, with: moduleName+fileName)
                        let newPath = filePath.replacingOccurrences(of: templateDirectoryPath.path + "/", with: "")
                        let resultPath = currentDirectoryPath.appendingPathComponent(newPath)
                        try resultFile.write(to: resultPath, atomically: true, encoding: .utf16)
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
    
}
