//
//  AccessKioskManager.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum ParkError: Swift.Error {
    
    case passGenerationError
    case requestingUnknownLocationAccess
    case unknown
}


class AccessKioskManager {
    
    //This class is responsible for granting/rejecting permission on passes assigned to users at various kiosks inside the park. Also responsible for error handling related to pass swiping.
    
    
    func swipe(pass: AreaAccessDataSource, atArea area: AreaAccess) throws -> Bool {
        
        if area == .undefined {
            //You are requesting access to an unknown/undefined location.
            throw ParkError.requestingUnknownLocationAccess
        }
        else if pass.areasAccessible.contains(.undefined) == true
            || pass.areasAccessible.isEmpty == true
        {
            //Your pass does not seem to have proper access. Pass not generated properly.
            throw ParkError.passGenerationError
        }
        else if pass.areasAccessible.contains(area) == true {
            //You have permission to access the requested area.
            return true
        }
        
        //No permission.
        return false
    }
    
    
    func swipeForRideWith(pass: RideAccessDataSource) throws -> (hasAccess: Bool, canSkipLine: Bool) {
        
        if pass.ridePrivileges.contains(.undefined) == true || pass.ridePrivileges.isEmpty == true {
            throw ParkError.passGenerationError
        }
        else {
            if pass.ridePrivileges.contains(.all) == false {
                //No access to rides. No question of skipping lines.
                return (hasAccess: false, canSkipLine: false)
            }
            else  {
                return (hasAccess: true, canSkipLine: pass.ridePrivileges.contains(.skipRideLines))
            }
        }
    }
    
    
    func swipeForFoodWith(pass: DiscountAccessDataSource) throws -> Int? {
        
        if pass.discountPrivileges.isEmpty == true {
            throw ParkError.passGenerationError
        }
        
        var discountValue: Int? = nil
        let _: Bool =  try pass.discountPrivileges.contains(where: ( { (dis: Discount) -> Bool in
            
            switch dis {
                
                case let .food(v1): discountValue = v1
                                    return true
                case .merchandise(_): return false
                case .none: return false
                case .undefined: throw ParkError.passGenerationError
                
            }
        }))
        
        return discountValue
        
    }
    
    
    func swipeForMerchandiseWith(pass: DiscountAccessDataSource) throws -> Int? {
        
        if pass.discountPrivileges.isEmpty == true {
            throw ParkError.passGenerationError
        }
        
        var discountValue: Int? = nil
        let _: Bool =  try pass.discountPrivileges.contains(where: ( { (dis: Discount) -> Bool in
            
            switch dis {
                
                case  .food(_): return false
                case let .merchandise(m1): discountValue = m1
                                           return true
                case .none: return false
                case .undefined: throw ParkError.passGenerationError
                
            }
        }))
        
        return discountValue

    }
    
    
}
