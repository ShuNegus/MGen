//
//  {{ModuleName}}ViewController.swift
//  Copyright © 2015 IVAN CHIRKOV. All rights reserved.
//

import UIKit

protocol %MODULENAME%ViewInput: class {
    
    func setupView()
    func updateView()
    
}

protocol %MODULENAME%ViewOutput: class {
    
    func setupView()
    
}

class %MODULENAME%ViewController: UIViewController {

    var output: %MODULENAME%ViewOutput!
    var router: %MODULENAME%Router!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.setupView()
    }
    
}

extension %MODULENAME%ViewController: %MODULENAME%ViewInput {

    func setupView() {

    }
    
    func updateView() {
        
    }
   
}
