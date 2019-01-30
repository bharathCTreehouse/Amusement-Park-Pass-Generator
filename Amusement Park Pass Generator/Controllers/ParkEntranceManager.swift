//
//  ParkEntranceManager.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 10/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum PassGenerationFailure: Swift.Error {
    case missingEntrantInformation (String)
    case passGenerationFailed
    case unknownError
}


class ParkEntranceManager {
    
    //Responsible for getting user details, creating entrant objects and pass generation. Also responsible for error handling related to user object creation and pass generation.
    
    var entrantCount: Int = 0
    
    
    func pass(forEntrantType entrantType: EntrantType) throws -> (AreaAccessDataSource & RideAccessDataSource & DiscountAccessDataSource) {
        
        var entrantPass: Pass? = nil
        let entrant: Entrant = Entrant(withType: entrantType, entrantNumber: (entrantCount + 1))
        
        switch entrantType {
            
            case .guest(.classic):
                entrantPass = Pass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .guest(.freeChild(birthDate)):
                //TODO: Exception handling wrt date
                entrantPass = ReminderPass(withPassNumber: (entrantCount + 1), dateOfBirth: birthDate, entrant: entrant)
            
            case .guest(.vip):
                entrantPass = VIPPass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .employee(.foodServices(name, address)):
                if let failedData = missingEntrantInfoString(fromEntrant: name, entrantAddress: address) {
                    throw PassGenerationFailure.missingEntrantInformation(failedData)
                }
                entrantPass = FoodServiceEmployeePass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .employee(.rideServices(name, address)):
                if let failedData = missingEntrantInfoString(fromEntrant: name, entrantAddress: address) {
                    throw PassGenerationFailure.missingEntrantInformation(failedData)
                }
                entrantPass = RideServiceEmployeePass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .employee(.maintenance(name, address)):
                if let failedData = missingEntrantInfoString(fromEntrant: name, entrantAddress: address) {
                    throw PassGenerationFailure.missingEntrantInformation(failedData)
                }
                entrantPass = MaintenanceEmployeePass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .manager(name, address):
                if let failedData = missingEntrantInfoString(fromEntrant: name, entrantAddress: address) {
                    throw PassGenerationFailure.missingEntrantInformation(failedData)
                }
                entrantPass = ManagerPass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
        }
        
        
        if entrantPass?.areasAccessible.isEmpty == true || entrantPass?.discountPrivileges.isEmpty == true || entrantPass?.ridePrivileges.isEmpty == true {
            
            throw PassGenerationFailure.passGenerationFailed
        }
        
        return entrantPass!
        
    }
    
    
    func missingEntrantInfoString(fromEntrant entrant: PersonName, entrantAddress address: Address) -> String? {
        
        if entrant.firstName.isEmpty == true {
            return "FirstName"
        }
        else if entrant.lastName.isEmpty == true {
            return "LastName"
        }
        else if address.city.isEmpty == true {
            return "City"
        }
        else if address.streetAddress.isEmpty == true {
            return "StreetDetails"
        }
        return nil
    }
    
}
