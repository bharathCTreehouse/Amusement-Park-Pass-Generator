//
//  ViewUtilities.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 20/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


enum ViewConstraint {
    
    case top (referenceConstraint: NSLayoutYAxisAnchor, constantOffSet: CGFloat , equalityType: constraintEqualityType )
    
    case bottom (referenceConstraint: NSLayoutYAxisAnchor, constantOffSet: CGFloat, equalityType: constraintEqualityType)
    
    case leading (referenceConstraint: NSLayoutXAxisAnchor, constantOffSet: CGFloat, equalityType: constraintEqualityType)
    
    case trailing (referenceConstraint: NSLayoutXAxisAnchor, constantOffSet: CGFloat, equalityType: constraintEqualityType)
    
    case width (constantOffSet: CGFloat, equalityType: constraintEqualityType)
    
    case height (constantOffSet: CGFloat, equalityType: constraintEqualityType)
    
    case centerX (referenceConstraint: NSLayoutXAxisAnchor, constantOffSet: CGFloat, equalityType: constraintEqualityType)
    
    case centerY (referenceConstraint: NSLayoutYAxisAnchor, constantOffSet: CGFloat , equalityType: constraintEqualityType)
}


enum constraintEqualityType {
    
    case equalTo
    case greaterThanOrEqualTo
    case lessThanOrEqualTo
}




extension UIView {
    
    
    func configure(withConstraints constraints: [ViewConstraint]) {
        
        
        translatesAutoresizingMaskIntoConstraints = false
        
        
        for (_, constraint) in constraints.enumerated() {
            
            switch constraint {
                
                 case let .leading(referenceConstraint: constraint,  constantOffSet: offSet, equalityType: type):
                    
                    if type == .equalTo {
                        leadingAnchor.constraint(equalTo: constraint, constant: offSet).isActive = true
                    }
                    else if type == .greaterThanOrEqualTo {
                        leadingAnchor.constraint(greaterThanOrEqualTo: constraint, constant: offSet).isActive = true
                    }
                    else {
                        leadingAnchor.constraint(lessThanOrEqualTo: constraint, constant: offSet).isActive = true
                    }
                
                 case let .trailing(referenceConstraint: constraint, constantOffSet: offSet, equalityType: type):
                
                    if type == .equalTo {
                        trailingAnchor.constraint(equalTo: constraint, constant: offSet).isActive = true
                    }
                    else if type == .greaterThanOrEqualTo {
                        trailingAnchor.constraint(greaterThanOrEqualTo: constraint, constant: offSet).isActive = true
                    }
                    else {
                        trailingAnchor.constraint(lessThanOrEqualTo: constraint, constant: offSet).isActive = true
                    }
                
                 case let .top(referenceConstraint: constraint, constantOffSet: offSet, equalityType: type):
                    
                    if type == .equalTo {
                        topAnchor.constraint(equalTo: constraint, constant: offSet).isActive = true
                    }
                    else if type == .greaterThanOrEqualTo {
                        topAnchor.constraint(greaterThanOrEqualTo: constraint, constant: offSet).isActive = true
                    }
                    else {
                        topAnchor.constraint(lessThanOrEqualTo: constraint, constant: offSet).isActive = true
                    }
                
                
                 case let .bottom(referenceConstraint: constraint, constantOffSet: offSet, equalityType: type):
                    
                    if type == .equalTo {
                        bottomAnchor.constraint(equalTo: constraint, constant: offSet).isActive = true
                    }
                    else if type == .greaterThanOrEqualTo {
                        bottomAnchor.constraint(greaterThanOrEqualTo: constraint, constant: offSet).isActive = true
                    }
                    else {
                        bottomAnchor.constraint(lessThanOrEqualTo: constraint, constant: offSet).isActive = true
                    }
                
                 case let .width(constantOffSet: offSet, equalityType: type):
                
                    if type == .equalTo {
                        widthAnchor.constraint(equalToConstant: offSet).isActive = true
                    }
                    else if type == .greaterThanOrEqualTo {
                        widthAnchor.constraint(greaterThanOrEqualToConstant: offSet).isActive = true
                    }
                    else {
                        widthAnchor.constraint(lessThanOrEqualToConstant: offSet).isActive = true
                    }
                
                
                 case let .height(constantOffSet: offSet, equalityType: type):
                
                    if type == .equalTo {
                        heightAnchor.constraint(equalToConstant: offSet).isActive = true
                    }
                    else if type == .greaterThanOrEqualTo {
                        heightAnchor.constraint(greaterThanOrEqualToConstant: offSet).isActive = true
                    }
                    else {
                        heightAnchor.constraint(lessThanOrEqualToConstant: offSet).isActive = true
                    }
                
                
                 case let .centerX(referenceConstraint: constraint, constantOffSet: offSet, equalityType: type):
                    
                    if type == .equalTo {
                        centerXAnchor.constraint(equalTo: constraint, constant: offSet).isActive = true
                    }
                    else if type == .greaterThanOrEqualTo {
                        centerXAnchor.constraint(greaterThanOrEqualTo: constraint, constant: offSet).isActive = true
                    }
                    else {
                        centerXAnchor.constraint(lessThanOrEqualTo: constraint, constant: offSet).isActive = true
                    }
                
                 case let .centerY(referenceConstraint: constraint, constantOffSet: offSet, equalityType: type):
                    
                    if type == .equalTo {
                        centerYAnchor.constraint(equalTo: constraint, constant: offSet).isActive = true
                    }
                    else if type == .greaterThanOrEqualTo {
                        centerYAnchor.constraint(greaterThanOrEqualTo: constraint, constant: offSet).isActive = true
                    }
                    else {
                        centerYAnchor.constraint(lessThanOrEqualTo: constraint, constant: offSet).isActive = true
                    }

            }
        }
    }
    
}
