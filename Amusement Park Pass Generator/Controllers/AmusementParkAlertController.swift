//
//  AmusementParkAlertController.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 28/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit



class AmusementParkAlertController {
    
    
    static func showAlertController(forViewController viewController: UIViewController, handler: ((Int) -> Void)?, listOfButtonTitles: [String], alertTitle: String?, alertMessage: String?) {
        
        
        let alertController: UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        
        for buttonTitle in listOfButtonTitles {
            
            let alertAction: UIAlertAction = UIAlertAction(title: buttonTitle, style: .default) { (action: UIAlertAction) in
                
                let index: Int? = alertController.actions.firstIndex(of: action)
                
                if let index = index, let handler = handler {
                    handler(index)
                }
                
                alertController.dismiss(animated: true, completion: nil)
                
            }
            
            alertController.addAction(alertAction)
        }
        
        
        
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
}
