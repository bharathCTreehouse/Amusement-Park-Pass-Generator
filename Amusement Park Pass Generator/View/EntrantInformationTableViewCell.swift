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
    func resetData()
}


class EntrantInformationTableViewCell: UITableViewCell, EntrantInformationViewProtocol {
    
   
    func enable(_ shouldEnable: Bool, view: UIView) {
        
        UIView.animate(withDuration: 0.6) {
            
            if shouldEnable == true {
                self.contentView.alpha = 1.0
            }
            else {
                self.contentView.alpha = 0.1
            }
            self.contentView.isUserInteractionEnabled = shouldEnable
        }
        
    }
    
    
    func resetData() {
        
    }
    
}
