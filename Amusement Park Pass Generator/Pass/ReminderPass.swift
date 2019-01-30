//
//  ReminderPass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 30/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

class ReminderPass: Pass, PersonalInformationReminder {
    
    let dateOfBirth: Date
    
    init(withPassNumber passNumber: Int, dateOfBirth: Date, entrant: Entrant) {
        self.dateOfBirth = dateOfBirth
        super.init(withPassNumber: passNumber, entrant: entrant)
    }
    
    var reminders: [InformationReminder] {
        return [InformationReminder.dataOfBirth(dateOfBirth)]
    }
}


