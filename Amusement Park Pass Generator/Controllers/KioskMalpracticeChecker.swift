//
//  KioskMalpracticeChecker.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 05/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

typealias PassIdentifier = Int


class KioskMalpracticeChecker {
    
    
    
    var rideCheckpointSwipeDetails: [PassIdentifier: Date] = [:]
    
    
    /*Check for malpractice (entrant trying to access ride within x seconds).*/

    func isEntrantTryingToCheatUsingPass(withPassIdentifier passNumber: PassIdentifier) -> Bool {
        
        guard let _ = rideCheckpointSwipeDetails[passNumber] else {
            //This pass has not yet been swiped at this ride.
            return false
        }
        return true
        
    }
}




extension KioskMalpracticeChecker {
    
    
    func storePass(withIdentifier passNumber: PassIdentifier, timeLimitInSeconds time: Int) {
        
        //Add the pass number to our log.
        rideCheckpointSwipeDetails.updateValue(Date(), forKey: passNumber)
        
        //Initiate a timer once every 'time' seconds to remove the given passNumber from our log.
        Timer.scheduledTimer(timeInterval: Double(time), target: self, selector: #selector(malpracticeTimerTriggered(withTimer:)), userInfo: passNumber, repeats: false)
        
    }
    
    
    
    @objc func malpracticeTimerTriggered(withTimer timer: Timer) {
        
        let passNumber: Int? = (timer.userInfo) as? PassIdentifier
        if let passNumber = passNumber {
            rideCheckpointSwipeDetails.removeValue(forKey: passNumber)
        }
        timer.invalidate()
        
    }
    
}
