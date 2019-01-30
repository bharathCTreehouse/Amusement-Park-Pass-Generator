//
//  PersonalInformationReminder.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 29/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum InformationReminder {
    case dataOfBirth(Date)
    case anniversaryDate(Date)
    case dateOfLastVisit(Date)
}


protocol PersonalInformationReminder {
    var reminders: [InformationReminder] { get }
}
