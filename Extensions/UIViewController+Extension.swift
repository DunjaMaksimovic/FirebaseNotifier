//
//  UIViewController+Extension.swift
//  FirebaseNotifier
//
//  Created by Nevena Maksimovic on 8/12/20.
//  Copyright © 2020 Dunja Maksimovic. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?, completion:(() -> Void)? = nil) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { alert in
            
            if let done = completion {
                done()
            }
        }
        
        alertVC.addAction(okAction)
        
        present(alertVC, animated: true)
    }
}
