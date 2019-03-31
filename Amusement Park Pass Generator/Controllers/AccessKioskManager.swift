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
    
    func userDisplayString() -> String {
        
        switch self {
            
            case .passGenerationError: return "Pass not generated properly.Please contact an admin."
            
            case .requestingUnknownLocationAccess: return "You are trying to access an unknown location."
            
            case .requestingAccessTooSoon: return "You seem to have accessed this ride just a few seconds ago. Please try again after sometime."
            
            default: return "An unknown error has occurred."
            
        }
    }
}


//This class is responsible for granting/rejecting permission on passes assigned to users at various kiosks inside the park. Also responsible for error handling related to pass swiping.


class AccessKioskManager {
    
    //MARK: - Polymorphic swiping methods
    
    lazy var malpracticeChecker: RideKioskMalpracticeChecker = RideKioskMalpracticeChecker()
    
    var accessSoundManager: AccessKioskSoundManager = AccessKioskSoundManager()
    
    
    //Can handle access to all kinds of area for any kind of pass.
    func swipe(pass: AccessDataSource, atArea area: AreaAccess) throws -> Bool {
        
        if pass.hasValidAreaAccess == false {
            //Your pass does not seem to have proper access. Pass not generated properly.
            //Play access denied sound.
            accessSoundManager.playSound(forAccessGrant: false)
            throw ParkError.passGenerationError

        }
        
        let accessGranted: Bool = pass.isPermitted(toArea: area)
        accessSoundManager.playSound(forAccessGrant: accessGranted)
        return accessGranted
        
    }
    
    
    //Can handle access to a ride for any kind of pass.
    func swipeForRideWith(pass: AccessDataSource) throws -> (hasAccess: Bool, canSkipLine: Bool) {
        
        if pass.hasValidRideAccess == false {
            accessSoundManager.playSound(forAccessGrant: false)
            throw ParkError.passGenerationError
        }
        else {
            
            let ride: (hasAccess: Bool, canSkipLines: Bool) = pass.isPermittedToAccessRides()
            
            if ride.hasAccess == true {
                
                //Entrant has access to ride.
                
                //Check for too soon access.
                let isSwipedRecently: Bool = entrantTryingToCheatUsing(pass: pass)
                
                if isSwipedRecently == true {
                    
                    //Play access denied sound.
                    accessSoundManager.playSound(forAccessGrant: false)
                    throw ParkError.requestingAccessTooSoon
                }
                else {
                    //Play access granted sound.
                    accessSoundManager.playSound(forAccessGrant: true)
                    
                    store(pass: pass, withTimeLimitInSeconds: 5)
                    return (hasAccess: true, canSkipLine: ride.canSkipLines)
                }
            }
            else {
                
                //Play access denied sound.
                accessSoundManager.playSound(forAccessGrant: false)

                //No access to rides. No question of skipping lines.
                return (hasAccess: false, canSkipLine: false)
                
            }
            
        }
        
    }
    
    
    //Can handle access to a food counter for any kind of pass.
    func swipeForFoodWith(pass: AccessDataSource) throws -> Int? {
        
        if  pass.hasValidDiscountAccess == false {
            accessSoundManager.playSound(forAccessGrant: false)
            throw ParkError.passGenerationError
        }
        else {
            
            guard let foodDiscount = pass.discountAtFoodCounter() else {
                accessSoundManager.playSound(forAccessGrant: false)
                return nil
            }
            accessSoundManager.playSound(forAccessGrant: true)
            return foodDiscount
        }
        
    }
    
    
    //Can handle access to a merchandise counter for any kind of pass.
    func swipeForMerchandiseWith(pass: AccessDataSource) throws -> Int? {
        
        if  pass.hasValidDiscountAccess == false {
            accessSoundManager.playSound(forAccessGrant: false)
            throw ParkError.passGenerationError
        }
        else {
            guard let merchDiscount = pass.discountAtMerchandiseCounter() else {
                accessSoundManager.playSound(forAccessGrant: false)
                return nil
            }
            accessSoundManager.playSound(forAccessGrant: true)
            return merchDiscount
            
        }
        
    }
    
}



extension AccessKioskManager {
    
    //MARK:  Birthday check


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




extension AccessKioskManager {
    
    //MARK:  Malpractice check

    
    private func entrantTryingToCheatUsing(pass: AccessDataSource) -> Bool {
        
        let isRecentlySwiped: Bool = malpracticeChecker.isEntrantTryingToCheatUsingPass(withPassIdentifier: pass.uniqueIdentifier)
        return isRecentlySwiped
        
    }
    
    
    private func store(pass: AccessDataSource, withTimeLimitInSeconds time: Int) {
        
        malpracticeChecker.storePass(withIdentifier: pass.uniqueIdentifier, timeLimitInSeconds: time)
    }
    
}
