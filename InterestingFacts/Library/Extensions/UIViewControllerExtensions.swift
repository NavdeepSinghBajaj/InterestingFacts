//
//  UIViewControllerExtensions.swift
//  InterestingFacts
//
//  Created by Navdeep Singh on 12/6/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import UIKit


// MARK: - UIViewController + UIAlertController
extension UIViewController {
    func alert(error: Error) {
        alert(title: "ERROR", message: error.localizedDescription, buttons: ["OK"], handler: nil)
    }
    
    func alert(error: String) {
        alert(title: "ERROR", message: error, buttons: ["OK"], handler: nil)
    }
    
    func alert(title: String? = nil, message: String, buttons: [String], handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for button in buttons {
            let action = UIAlertAction(title: button, style: .default, handler: { action in
                handler?(action)
            })
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
