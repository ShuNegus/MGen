//
//  %MODULENAME%Router.swift
//
//  Created by %CREATER% on %DATE%.
//  Copyright © %COPYRIGHT%. All rights reserved.
//

import UIKit

class %MODULENAME%Router {
    
    weak var view: UIViewController!
    
    func presentErrorWithTitle(_ title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
}
