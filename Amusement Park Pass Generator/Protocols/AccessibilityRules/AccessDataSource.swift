//
//  AccessDataSource.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 31/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

typealias PassIdentifier = Int


protocol AccessDataSource: AreaAccessDataSource, RideAccessDataSource, DiscountAccessDataSource {
    
    var uniqueIdentifier: PassIdentifier { get }
}



extension AccessDataSource {
    
    var hasValidAreaAccess: Bool {
        return !areasAccessible.isEmpty && uniqueIdentifier.isValid
    }
    
    
    var hasValidRideAccess: Bool {
        return uniqueIdentifier.isValid
    }
    
    
    var hasValidDiscountAccess: Bool {
        
        return uniqueIdentifier.isValid
        
        //var hasFailed: Bool = discountPrivileges.isEmpty == true ||  !uniqueIdentifier.isValid
        
        /*if hasFailed == false {
            
            let _: Bool =  discountPrivileges.contains(where: ( { (discount: Discount) -> Bool in
                
                switch discount {
                    case .undefined: hasFailed = true
                    default: hasFailed = false
                    
                }
                return hasFailed
            }))
            
            return !hasFailed
            
        }
        else {
            return !hasFailed
        }*/
        
    }
}



extension AccessDataSource {
    
    func isPermitted(toArea area: AreaAccess) -> Bool {
        return areasAccessible.contains(area)
    }
    
    
    func isPermittedToAccessRides() -> (hasAccess: Bool, canSkipLines: Bool) {
        
        if !ridePrivileges.contains(.all) {
            return (hasAccess: false, canSkipLines: false)
        }
        else {
            return (hasAccess: true, canSkipLines: ridePrivileges.contains(.skipRideLines))
        }
    }
    
    
    func discountAtFoodCounter() -> Int? {
        
        var discountValue: Int? = nil
        
        let _: Bool =  discountPrivileges.contains(where: ( { (discount: Discount) -> Bool in
            
            switch discount {
                
                case let .food(value): discountValue = value
                                       return true
                default: return false
                
            }
        }))
        
        return discountValue
        
    }
    
    
    
    func discountAtMerchandiseCounter() -> Int? {
        
        var discountValue: Int? = nil
        
        let _: Bool = discountPrivileges.contains(where: ( { (discount: Discount) -> Bool in
            
            switch discount {
                
                case let .merchandise(value): discountValue = value
                                              return true
                default: return false
                
            }
        }))
        
        return discountValue
        
    }
    
}




extension PassIdentifier {
    
    var isValid: Bool {
        return self > 0
    }
    
}
