//
//  ReminderPass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 30/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

class ReminderPass: Pass, PersonalInformationReminder {
    
    var reminders: [InformationReminder] {
        
        if let dob = entrant.type.dateOfBirthOfEntrant() {
            return [InformationReminder.dataOfBirth(dob)]
        }
        else {
            return []
        }
    }
}


