//
//  EntrantInformationTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 10/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit

protocol EntrantInformationViewProtocol {
    func enable(_ shouldEnable: Bool, view: UIView)
}



class EntrantInformationTableViewCell: UITableViewCell, EntrantInformationViewProtocol {
    
    
    override func awakeFromNib() {
        selectionStyle = .none
    }
   
    
    func enable(_ shouldEnable: Bool, view: UIView) {
        
        UIView.animate(withDuration: 0.6) {
            
            if shouldEnable == true {
                view.alpha = 1.0
            }
            else {
                view.alpha = 0.1
            }
            view.isUserInteractionEnabled = shouldEnable
        }
        
    }
    
}
