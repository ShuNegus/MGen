//
//  %MODULENAME%Module.swift
//
//  Created by %CREATER% on %DATE%.
//  Copyright © %COPYRIGHT%. All rights reserved.
//

import UIKit

class %MODULENAME%Module {
    
    private var viewController: %MODULENAME%ViewController?
    
    var view: UIViewController {
        guard let view = viewController else {
            viewController = %MODULENAME%ViewController(nibName: "%MODULENAME%ViewController", bundle: nil)
            configureModuleWithView(self.viewController!)
            return self.viewController!
        }
        return view
    }

private func configureModuleWithView(_ view: %MODULENAME%ViewController) {
        let presenter = %MODULENAME%Presenter()
        let router = %MODULENAME%Router()
        let interactor = %MODULENAME%Interactor()
        router.view = view
        view.output = presenter
        view.router = router
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.output = presenter
        
    }
    
}
