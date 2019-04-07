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
                
                do {
                    try DateValidator.validate(date: birthDate, forDateType: TypeOfDate.dateOfBirth(withCriteria: Criteria.under(age: 5)))
                    entrantPass = ReminderPass(withPassNumber: (entrantCount + 1), entrant: entrant)
                }
                catch DateError.invalidDate {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth entered is invalid")
                }
                catch DateError.missingDate {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth is missing")
                }
                catch DateError.failedToValidate {
                    throw PassGenerationFailure.passGenerationFailed("Could not validate date of birth. Please try again")
                }
            
            
            case .guest(.vip):
                entrantPass = VIPPass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .guest(.seasonPassGuest(name, address)):
                try validate(name: name, address: address)
                entrantPass = SeasonPass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .guest(.seniorGuest(name, dateOfBirth: birthDate)):
                
                try validate(name: name)
                
                do {
                    try DateValidator.validate(date: birthDate, forDateType: TypeOfDate.dateOfBirth(withCriteria: Criteria.above(age: 59)))
                    entrantPass = SeniorCitizenPass(withPassNumber: (entrantCount + 1), entrant: entrant)
                }
                catch DateError.invalidDate {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth entered is invalid")
                }
                catch DateError.missingDate {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth is missing")
                }
                catch DateError.failedToValidate {
                    throw PassGenerationFailure.passGenerationFailed("Could not validate date of birth. Please try again")
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
                else if project!.containsOnlyNumbers() == false {
                    
                    throw PassGenerationFailure.passGenerationFailed("Project information is invalid")
                }
                entrantPass = ContractEmployeePass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            
            case let .manager(name, address):
                try validate(name: name, address: address)
                entrantPass = ManagerPass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            
            case let .vendor(name, company, dateOfBirth: birthDate, dateOfVisit: visitDate):
            
                try validate(name: name)
                if company == nil {
                    throw PassGenerationFailure.passGenerationFailed("Company information is missing")
                }
                else if company!.containsCharactersOtherThanAlphabetsAndWhiteSpaces() == true {
                    throw PassGenerationFailure.passGenerationFailed("Company information is invalid")
                }
                else if visitDate == nil {
                    throw PassGenerationFailure.passGenerationFailed("Failed to generate date of visit")
                }
                
                //Have set the criteria for a vendor to be above the age of 13 - Child Labour law in India :)
                do {
                    try DateValidator.validate(date: birthDate, forDateType: TypeOfDate.dateOfBirth(withCriteria: Criteria.above(age: 13)))
                    
                    entrantPass = VendorPass(withPassNumber: (entrantCount + 1), entrant: entrant)
                    
                }
                catch DateError.invalidDate {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth entered is invalid")
                }
                catch DateError.missingDate {
                    throw PassGenerationFailure.passGenerationFailed("Date of birth is missing")
                }
                catch DateError.failedToValidate {
                    throw PassGenerationFailure.passGenerationFailed("Could not validate date of birth. Please try again")
                }
            
        }
        
        
       if entrantPass?.areasAccessible.isEmpty == true {
            
            throw PassGenerationFailure.passGenerationFailed("Unable to provide required access.")
        }
        
        return entrantPass!
        
    }
    
    
    func missingOrInvalidInfo(fromEntrantName entrant: PersonName) -> PersonNameError? {
        
        do {
            try entrant.validate()
        }
        catch let error as PersonNameError {
            return error
        }
        catch {
            
        }
        
        return nil
        
    }
    
    
    func missingOrInvalidInfo(fromEntrantAddress address: Address) -> AddressError? {
        
        do {
            try address.validate()
        }
        catch let error as AddressError {
            return error
        }
        catch {
            
        }
        return nil
        
    }
    
}
