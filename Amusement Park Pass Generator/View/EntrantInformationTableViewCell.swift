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


enum EntrantInfoCellState {
    
    case active
    case inActive
    
    static func state(fromBool state: Bool) -> EntrantInfoCellState {
        
        if state == true {
            return .active
        }
        else {
            return .inActive
        }
    }
}


class EntrantInformationTableViewCell: UITableViewCell, EntrantInformationViewProtocol {
    
    var state: EntrantInfoCellState = .active
    
    
    
    override func awakeFromNib() {
        selectionStyle = .none
    }
   
    
    func enable(_ shouldEnable: Bool, view: UIView) {
        
        
        state = EntrantInfoCellState.state(fromBool: shouldEnable)
        
        UIView.animate(withDuration: 0.6) {
            
            if shouldEnable == true {
                view.alpha = 1.0
            }
            else {
                view.alpha = 0.1
            }
            view.isUserInteractionEnabled = shouldEnable
        }
        
        performAdditionalCustomization()
        
    }
    
    
    func resetData() {
        
    }
    
    
    
    func performAdditionalCustomization() {
        
    }
    
}
