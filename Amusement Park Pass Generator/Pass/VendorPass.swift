//
//  VendorPass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 30/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum CompaniesRegistered {
    
    case acme
    case orkin
    case fedex
    case nwElectrical
    
    var displayString: String {
        
        switch self {
            case .acme: return "Acme"
            case .orkin: return "Orkin"
            case .fedex: return "Fedex"
            case .nwElectrical: return "NW Electrical"
            
        }
    }
    
    
    static func orderedDisplayableCompanyList() -> [String] {
        return ["Acme", "Orkin", "Fedex", "NW Electrical"]
    }
    
    static func orderedCompanyList() -> [CompaniesRegistered] {
        return [.acme, orkin, fedex, nwElectrical]
    }
}


class VendorPass: ReminderPass {
    
    let company: String
    let dateOfLastVisit: Date
    
    init(withPassNumber passNumber: Int, lastVisitDate: Date, entrant: Entrant, nameOfCompany: String, dateOfBirth: Date) {
        
        company = nameOfCompany
        dateOfLastVisit = lastVisitDate
        super.init(withPassNumber: passNumber, dateOfBirth: dateOfBirth, entrant: entrant)
    }
    
    
    override var reminders: [InformationReminder] {
        
        var reminderCollection: [InformationReminder] = super.reminders
        reminderCollection.append(InformationReminder.dateOfLastVisit(dateOfLastVisit))
        return reminderCollection
    }
    
    
    override var areasAccessible: [AreaAccess] {
        
        var areas: [AreaAccess] = super.areasAccessible
        areas.append(.kitchen)
        return areas

        
    }
}

