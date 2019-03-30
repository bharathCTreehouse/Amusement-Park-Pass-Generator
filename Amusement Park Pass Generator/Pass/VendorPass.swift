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
    
    
    func areasPermittedToAccess() -> [AreaAccess] {
        
        switch self {
            
            case .acme: return [.kitchen]
            case .orkin: return [.amusement, .rideControl, .kitchen]
            case .fedex: return [.maintenance, .office]
            case .nwElectrical: return [.amusement, .rideControl, .kitchen, .maintenance, .office]
        }
        
    }
}


class VendorPass: ReminderPass {
    
    override var areasAccessible: [AreaAccess] {
        
        if let company = self.entrant.type.companyEntrantBelongsTo() {
            return company.areasPermittedToAccess()
        }
        else {
            return super.areasAccessible
        }
    }
    
    
    override var ridePrivileges: [RideAccess] {
        return []
    }
    
    
    override var informationCollected: [PersonalInfo] {
        
        var data: [PersonalInfo] = super.informationCollected
        if let company = self.entrant.type.companyEntrantBelongsTo() {
            data.append(PersonalInfo.company(company))
        }
        return data
    }
}

