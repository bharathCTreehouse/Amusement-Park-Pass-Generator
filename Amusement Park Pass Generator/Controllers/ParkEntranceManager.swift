//
//  ParkEntranceManager.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 10/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum PassGenerationFailure: Swift.Error {
    //case missingEntrantInformation (String)  //??
    //case invalidEntrantInformation (String)  //??
    case passGenerationFailed(String)
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
                do {
                   try DateValidator.validate(date: birthDate, forDateType: TypeOfDate.dateOfBirth(withLimit: LimitType.under(5)))
                    
                    entrantPass = ReminderPass(withPassNumber: (entrantCount + 1), dateOfBirth: birthDate, entrant: entrant)
                }
                catch DateError.invalidDate {
                    throw PassGenerationFailure.passGenerationFailed("BirthDate entered is invalid.")
                }
                catch DateError.missingDate {
                    throw PassGenerationFailure.passGenerationFailed("BirthDate is missing.")
                }
            
            
            case .guest(.vip):
                entrantPass = VIPPass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .employee(.foodServices(name, address)):
                if let nameError = missingOrInvalidInfo(fromEntrantName: name) {
                    throw PassGenerationFailure.passGenerationFailed(nameError.userDisplayString())
                   }
                if let addressError = missingOrInvalidInfo(fromEntrantAddress: address) {
                    throw PassGenerationFailure.passGenerationFailed(addressError.userDisplayString())
                }
                entrantPass = FoodServiceEmployeePass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .employee(.rideServices(name, address)):
                if let nameError = missingOrInvalidInfo(fromEntrantName: name) {
                    throw PassGenerationFailure.passGenerationFailed(nameError.userDisplayString())
                }
                if let addressError = missingOrInvalidInfo(fromEntrantAddress: address) {
                    throw PassGenerationFailure.passGenerationFailed(addressError.userDisplayString())
                }
                entrantPass = RideServiceEmployeePass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .employee(.maintenance(name, address)):
                if let nameError = missingOrInvalidInfo(fromEntrantName: name) {
                    throw PassGenerationFailure.passGenerationFailed(nameError.userDisplayString())
                }
                if let addressError = missingOrInvalidInfo(fromEntrantAddress: address) {
                    throw PassGenerationFailure.passGenerationFailed(addressError.userDisplayString())
                }
                entrantPass = MaintenanceEmployeePass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
            case let .manager(name, address):
                if let nameError = missingOrInvalidInfo(fromEntrantName: name) {
                    throw PassGenerationFailure.passGenerationFailed(nameError.userDisplayString())
                }
                if let addressError = missingOrInvalidInfo(fromEntrantAddress: address) {
                    throw PassGenerationFailure.passGenerationFailed(addressError.userDisplayString())
                }
                entrantPass = ManagerPass(withPassNumber: (entrantCount + 1), entrant: entrant)
            
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
