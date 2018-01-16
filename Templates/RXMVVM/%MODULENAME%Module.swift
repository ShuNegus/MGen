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
        let router = %MODULENAME%Router()
        router.viewController = view
        let viewModel = %MODULENAME%ViewModel()
        viewModel.router = router
        view.viewModel = viewModel
    }
    
}
