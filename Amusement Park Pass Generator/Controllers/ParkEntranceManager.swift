//
//  ParkEntranceManager.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 10/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum PassGenerationFailure: Swift.Error {
    case passGenerationFailed(String)
    case unknownError
}


//Responsible for getting user details, creating entrant objects and pass generation. Also responsible for error handling related to user object creation and pass generation.


class ParkEntranceManager {
    
    
    var entrantCount: Int = 0
    
    
    func pass(forEntrantType entrantType: EntrantType) throws -> AccessDataSource {
        
        var entrantPass: Pass? = nil
        let entrant: Entrant = Entrant(withType: entrantType, entrantNumber: (entrantCount + 1))
        
        
        func validate(name: PersonName?) throws {
            
            if name == nil {
                throw PassGenerationFailure.passGenerationFailed("Please enter first and last name")
            }
            if let nameError = missingOrInvalidInfo(fromEntrantName: name!) {
                throw PassGenerationFailure.passGenerationFailed(nameError.userDisplayString())
            }
        }
        
        func validate(address: Address?) throws {
            
            if address == nil {
                throw PassGenerationFailure.passGenerationFailed("Please enter address")
            }
            if let addressError = missingOrInvalidInfo(fromEntrantAddress: address!) {
                throw PassGenerationFailure.passGenerationFailed(addressError.userDisplayString())
            }
        }
        
        func validate(name: PersonName?, address: Address?) throws {
            
            try validate(name: name)
            try validate(address: address)
        }
        
        
        switch entrantType {
            
            case .guest(.classic):
                entrantPass = Pass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .guest(.freeChild(dateOfBirth: birthDate)):
                
                if birthDate == nil {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth is missing")
                }
                do {
                    try DateValidator.validate(date: birthDate, forDateType: TypeOfDate.dateOfBirth(withCriteria: Criteria.under(age: 5)))
                    entrantPass = ReminderPass(withPassNumber: (entrantCount + 1), dateOfBirth: birthDate!, entrant: entrant)
                }
                catch DateError.invalidDate {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth entered is invalid")
                }
                catch DateError.missingDate {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth is missing")
                }
            
            
            case .guest(.vip):
                entrantPass = VIPPass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .guest(.seasonPassGuest(name, address)):
                try validate(name: name, address: address)
                entrantPass = SeasonPass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .guest(.seniorGuest(name, dateOfBirth: birthDate)):
                
                try validate(name: name)
                
                if birthDate == nil {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth is missing")
                }
                do {
                    try DateValidator.validate(date: birthDate, forDateType: TypeOfDate.dateOfBirth(withCriteria: Criteria.above(age: 59)))
                    entrantPass = SeniorCitizenPass(withPassNumber: (entrantCount + 1), dateOfBirth: birthDate!, entrant: entrant)
                }
                catch DateError.invalidDate {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth entered is invalid")
                }
                catch DateError.missingDate {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth is missing")
            }
            

            case let .employee(.foodServices(name, address)):
                try validate(name: name, address: address)
                entrantPass = FoodServiceEmployeePass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .employee(.rideServices(name, address)):
                try validate(name: name, address: address)
                entrantPass = RideServiceEmployeePass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .employee(.maintenance(name, address)):
                try validate(name: name, address: address)
                entrantPass = MaintenanceEmployeePass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .employee(.contract(name, address, project)):
                try validate(name: name, address: address)
                if project == nil {
                    throw PassGenerationFailure.passGenerationFailed("Project information is missing")
                }
                entrantPass = ContractEmployeePass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            
            case let .manager(name, address):
                try validate(name: name, address: address)
                entrantPass = ManagerPass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            
            case let .vendor(name, company, dateOfBirth: birthDate):
                try validate(name: name)
                if company == nil {
                    throw PassGenerationFailure.passGenerationFailed("Company information is missing")
                }
                else if birthDate == nil {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth is missing")
                }
                entrantPass = VendorPass(withPassNumber: (entrantCount + 1), dateOfBirth: birthDate!, entrant: entrant)
            
        }
        
        
       if entrantPass?.areasAccessible.isEmpty == true || entrantPass?.discountPrivileges.isEmpty == true || entrantPass?.ridePrivileges.isEmpty == true {
            
            throw PassGenerationFailure.passGenerationFailed("Unable to provide required access.")
        }
        
        return entrantPass!
        
    }
    
    
    func missingOrInvalidInfo(fromEntrantName entrant: PersonName) -> PersonNameError? {
        
        do {
            try entrant.validate()
        }
        catch PersonNameError.invalidFirstName {
            return PersonNameError.invalidFirstName
        }
        catch PersonNameError.missingFirstName {
            return PersonNameError.missingFirstName
        }
        catch PersonNameError.invalidLastName {
            return PersonNameError.invalidLastName
        }
        catch {
            
        }
        
        return nil
        
    }
    
    
    func missingOrInvalidInfo(fromEntrantAddress address: Address) -> AddressError? {
        
        do {
            try address.validate()
        }
        catch AddressError.missingStreetDetails {
            return AddressError.missingStreetDetails
        }
        catch AddressError.missingCity {
            return AddressError.missingCity
        }
        catch {
            
        }
        return nil
        
    }
    
}
