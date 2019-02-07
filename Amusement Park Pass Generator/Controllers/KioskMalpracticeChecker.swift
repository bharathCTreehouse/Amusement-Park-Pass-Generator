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
    
    
    /*Check for malpractice (guest trying to access ride within x seconds).*/

    func hasEntrantAccessedRide(withPassIdentifier passNumber: PassIdentifier, withinTimeLimitInSeconds time: Int ) -> Bool {
        
        guard let swipedDate = rideCheckpointSwipeDetails[passNumber] else {
            //This pass has not yet been swiped at this ride.
            return false
        }
        
        //This pass has been swiped at this ride. So we will have to check the elapsed time.
        let interval: TimeInterval = Date().timeIntervalSince(swipedDate)
        
        //This pass has been swiped at this ride. If it has been more than 5 seconds, then allow access.
        return (interval <= Double(time))
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
