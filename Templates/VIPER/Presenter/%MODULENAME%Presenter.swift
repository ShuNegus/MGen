//
//  %MODULENAME%Presenter.swift
//
//  Created by %CREATER% on %DATE%.
//  Copyright © %COPYRIGHT%. All rights reserved.
//
import Foundation

extension %MODULENAME%Presenter: %MODULENAME%ViewOutput {
    
    func setupView() {
        view.setupView()
    }

}

extension %MODULENAME%Presenter: %MODULENAME%InteractorOutput {
    
    func errorReceived(message: String) {
        router.presentErrorWithTitle("Error", message: message)
    }

}

class %MODULENAME%Presenter {
    
    weak var view: %MODULENAME%ViewInput!
    var router: %MODULENAME%Router!
    var interactor: %MODULENAME%InteractorInput!
    
}
