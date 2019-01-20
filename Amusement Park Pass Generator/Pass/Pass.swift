//
//  Pass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

class Pass: AreaAccessDataSource, RideAccessDataSource, DiscountAccessDataSource {
    
    var passNumber: Int = 0  //Pass number should be assigned with entrant number.
    var displayableDataSource: EntrantInformationDisplayable
    var wisherDataSource: EntrantWisher?
    
    init(withPassNumber passIdentifier: Int, displayableDataSource displayDataSource: EntrantInformationDisplayable, entrantWisherDataSource wisherDataSource: EntrantWisher? = nil) {
        
        passNumber = passIdentifier
        self.displayableDataSource = displayDataSource
        self.wisherDataSource = wisherDataSource
    }
    
    
    var areasAccessible: [AreaAccess] {
        return [.amusement]
    }
    
    var ridePrivileges: [RideAccess] {
        return [.all]
    }
    
    var discountPrivileges: [Discount] {
        return [.none]
    }
}



/*extension Pass {
    
    var isValid: Bool {
        
        if areasAccessible.isEmpty == true || discountPrivileges.isEmpty == true || ridePrivileges.isEmpty == true {
            
            return false
        }
        return true
    }
}*/

