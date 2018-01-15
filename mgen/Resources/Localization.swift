//
//  Localization.swift
//  mgen
//
//  Created by Vladimir Shutov on 11.01.2018.
//  Copyright © 2018 smd. All rights reserved.
//

import Foundation

class Localization {
    static let about = "MGen is a tool for code generation of modules from the template"
    static let version = "MGen v \(Config.version)"
    static let help =
    """
    Usage:
    mgen <ModuleName> [<ModuleType>]

    Exemple:
    mgen NewsList -mvvm

    Result:
    ├── NewsListModule.swift
    ├── NewsListRouter.swift
    ├── NewsListViewModel.swift
    └── NewsListViewController.swift
    """
    
    static let inputError = "Command not found. Use -h to see help message"
    static let templateDirectoryError = "Template directory not found"
}
