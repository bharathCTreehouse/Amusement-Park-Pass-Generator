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
    case requestingAccessTooSoon
    case unknown
}


class AccessKioskManager {
    
    //This class is responsible for granting/rejecting permission on passes assigned to users at various kiosks inside the park. Also responsible for error handling related to pass swiping.
    
    var malpracticeChecker: KioskMalpracticeChecker? = nil
    
    
    func swipe(pass: AreaAccessDataSource, atArea area: AreaAccess) throws -> Bool {
        
        if area == .undefined {
            //You are requesting access to an unknown/undefined location.
            throw ParkError.requestingUnknownLocationAccess
        }
        else if pass.areasAccessible.contains(.undefined) == true
            || pass.areasAccessible.isEmpty == true ||  pass as? AccessDataSource == nil
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
        
        //First check for malpractice.
        if pass.ridePrivileges.contains(.undefined) == true || pass.ridePrivileges.isEmpty == true || pass as? AccessDataSource == nil {
            throw ParkError.passGenerationError
        }
        else {
            if pass.ridePrivileges.contains(.all) == false {
                //No access to rides. No question of skipping lines.
                return (hasAccess: false, canSkipLine: false)
            }
            else  {
                //Entrant has access to ride. Check for too soon access.
                let isSwipedRecently: Bool = entrantTryingToCheatUsing(pass: pass as! AccessDataSource)
                if isSwipedRecently == true {
                    throw ParkError.requestingAccessTooSoon
                }
                else {
                    store(pass: pass as! AccessDataSource, withTimeLimitInSeconds: 5)
                    return (hasAccess: true, canSkipLine: pass.ridePrivileges.contains(.skipRideLines))
                }
            }
        }
        
    }
    
        
    func swipeForFoodWith(pass: DiscountAccessDataSource) throws -> Int? {
        
        if  pass.discountPrivileges.isEmpty == true || pass as? AccessDataSource == nil {
            throw ParkError.passGenerationError
        }
        
        var discountValue: Int? = nil
        let _: Bool =  try pass.discountPrivileges.contains(where: ( { (discount: Discount) -> Bool in
            
            switch discount {
                
                case let .food(value): discountValue = value
                                      return true
                case .merchandise(_): return false
                case .none: return false
                case .undefined: throw ParkError.passGenerationError
                
            }
        }))
        
        return discountValue
        
    }
    
    
    func swipeForMerchandiseWith(pass: DiscountAccessDataSource) throws -> Int? {
        
        if pass.discountPrivileges.isEmpty == true || pass as? AccessDataSource == nil {
            throw ParkError.passGenerationError
        }
        
        var discountValue: Int? = nil
        let _: Bool =  try pass.discountPrivileges.contains(where: ( { (discount: Discount) -> Bool in
            
            switch discount {
                
                case  .food(_): return false
                case let .merchandise(value): discountValue = value
                                           return true
                case .none: return false
                case .undefined: throw ParkError.passGenerationError
                
            }
        }))
        
        return discountValue

    }
    
}


//Wish checker
extension AccessKioskManager {
    
    private func birthDateOfEntrant(withPass pass: PersonalInformationReminder) -> Date? {
        
        var birthDate:Date? = nil
        
        let _: Bool =  pass.reminders.contains(where: ( { (reminder: InformationReminder) -> Bool in
            
            switch reminder {
                
                case let .dataOfBirth(date): birthDate = date
                                             return true
                default:  return false
                
                
            }
        }))
        
        return birthDate
    }
    
    
    func isTodayBirthdayOfEntrant(withPass pass: PersonalInformationReminder) -> Bool? {
        
        if let dob = birthDateOfEntrant(withPass: pass) {
            
            let bDateFormatter: DateFormatter = DateFormatter()
            bDateFormatter.dateFormat = "MMM d"
            return bDateFormatter.string(from: dob)  ==  bDateFormatter.string(from: Date())
        }
        return nil
    }
    
    
}



//Malpractice check initiation.
extension AccessKioskManager {
    
    func entrantTryingToCheatUsing(pass: AccessDataSource) -> Bool {
        
        if malpracticeChecker == nil {
            malpracticeChecker = KioskMalpracticeChecker()
        }
        let isRecentlySwiped: Bool = malpracticeChecker!.isEntrantTryingToCheatUsingPass(withPassIdentifier: pass.uniqueIdentifier)
        return isRecentlySwiped
        
    }
    
    
   func store(pass: AccessDataSource, withTimeLimitInSeconds time: Int) {
        
        if malpracticeChecker == nil {
            malpracticeChecker = KioskMalpracticeChecker()
        }
        malpracticeChecker!.storePass(withIdentifier: pass.uniqueIdentifier, timeLimitInSeconds: time)
    }
    
}
