//
//  main.swift
//  mgen
//
//  Created by Vladimir Shutov on 10.01.2018.
//  Copyright © 2018 smd. All rights reserved.
//

import Foundation

let mgen = MGen()

var arguments = CommandLine.arguments
arguments.removeFirst()
mgen.startWithArguments(arguments)
