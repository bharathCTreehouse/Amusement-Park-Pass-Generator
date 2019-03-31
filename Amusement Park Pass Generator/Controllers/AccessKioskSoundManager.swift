//
//  AccessKioskSoundManager.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 31/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import AudioToolbox


class AccessKioskSoundManager {
    
    var swipeSoundForAccessGrant: SystemSoundID = 0
    var swipeSoundForAccessReject: SystemSoundID = 1
    
    init() {
        
        //Create system sound for access grant
        let accessGrantedSoundPath = Bundle.main.path(forResource: "AccessGranted", ofType: "wav")
        let accessGrantSoundUrl = URL(fileURLWithPath: accessGrantedSoundPath!)
        AudioServicesCreateSystemSoundID(accessGrantSoundUrl as CFURL, &swipeSoundForAccessGrant)
        
        
        //Create system sound for access rejection
        let accessRejectedSoundPath = Bundle.main.path(forResource: "AccessDenied", ofType: "wav")
        let accessRejectSoundUrl = URL(fileURLWithPath: accessRejectedSoundPath!)
        AudioServicesCreateSystemSoundID(accessRejectSoundUrl as CFURL, &swipeSoundForAccessReject)
    }
    
    
    func playSound(forAccessGrant hasAccess: Bool) {
        
        if hasAccess == true {
            AudioServicesPlaySystemSound(swipeSoundForAccessGrant)
        }
        else {
            AudioServicesPlaySystemSound(swipeSoundForAccessReject)
        }
        
    }
    
}
