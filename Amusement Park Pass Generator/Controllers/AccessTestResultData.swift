//
//  AccessTestResultData.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 23/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


protocol AccessTestResultProtocol {
    
    var accessTestIndicationColor: UIColor { get }
    var primaryResultText: String { get }
    var secondaryResultText: String? { get }
    var specialMessageText: String? { get }
    
}



enum AccessStatus {
    
    case initial (color: UIColor, primaryResultText: String)
    case granted (color: UIColor, primaryResultText: String)
    case rejected (color: UIColor, primaryResultText: String)
}



struct AccessTestResultData {
    
    var accessStatus: AccessStatus
    var secondaryText: String?
    var specialWishText: String?
    
    
    
    init(withAccessStatus status: AccessStatus, secondaryResultText: String? = nil, specialMessageText: String? = nil) {
        
        accessStatus = status
        secondaryText = secondaryResultText
        specialWishText = specialMessageText
        
    }
}


extension AccessTestResultData: AccessTestResultProtocol {
    
    var accessTestIndicationColor: UIColor {
        
        switch accessStatus {
            
            case let .granted(color: colorToUse, _): return colorToUse
            case let .rejected(color: colorToUse, _): return colorToUse
            case let .initial(color: colorToUse, _): return colorToUse

            
        }
    }
    
    
    var primaryResultText: String {
        
        switch accessStatus {
            
            case let .granted(_, primaryResultText: text): return text
            case let .rejected(_, primaryResultText: text): return text
            case let .initial(_, primaryResultText: text): return text

            
        }
    }
    
    
    var secondaryResultText: String? {
        return secondaryText
    }
    
    
    var specialMessageText: String? {
        return specialWishText
    }
}
