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
    
    
    func entrant(forType entrantType: EntrantType) throws -> Entrant {
        
        var parkEntrant: Entrant? = nil
        
        switch entrantType {
            
        case .guest(.classic):
            let display: EntrantInformationDisplayable = PassDisplay(name:nil, entrantTypeDescription:"Classic Guest Pass")
            let classicPass: Pass = Pass(withPassNumber: (entrantCount + 1), displayableDataSource: display)
            parkEntrant = Entrant(withPass: classicPass, entrantType: entrantType, entrantNumber: (entrantCount + 1))
            
            
        case let .guest(.freeChild(birthDate)):
            do {
                let wish: EntrantWisher = try Wish(withDateOfBirth: birthDate)
                let display: EntrantInformationDisplayable = PassDisplay(name:nil, entrantTypeDescription:"Child Guest Pass")
                let childPass: Pass = Pass(withPassNumber: (entrantCount + 1), displayableDataSource: display, entrantWisherDataSource: wish)
                parkEntrant = Entrant(withPass: childPass, entrantType: entrantType, entrantNumber: (entrantCount + 1))
            }
            catch DateError.invalidDateOfBirth {
                throw PassGenerationFailure.missingEntrantInformation("DOB")
            }
            catch  {
                throw PassGenerationFailure.unknownError
            }
            
            
        case .guest(.vip):
            let display: EntrantInformationDisplayable = PassDisplay(name:nil, entrantTypeDescription:"VIP Guest Pass")
            let vipPass: VIPPass = VIPPass(withPassNumber: (entrantCount + 1), displayableDataSource: display)
            parkEntrant = Entrant(withPass: vipPass, entrantType: entrantType, entrantNumber: (entrantCount + 1))
            
        case let .employee(.foodServices(entrant, address)):
            if let failedData = missingEntrantInfoString(fromEntrant: entrant, entrantAddress: address) {
                throw PassGenerationFailure.missingEntrantInformation(failedData)
            }
            let display: EntrantInformationDisplayable = PassDisplay(name:entrant.fullName(), entrantTypeDescription:"Food services Employee Pass")
            let foodEmployeePass: FoodServiceEmployeePass = FoodServiceEmployeePass(withPassNumber: (entrantCount + 1), displayableDataSource: display)
            parkEntrant = Entrant(withPass: foodEmployeePass, entrantType: entrantType, entrantNumber: (entrantCount + 1))
            
            
        case let .employee(.rideServices(entrant, address)):
            if let failedData = missingEntrantInfoString(fromEntrant: entrant, entrantAddress: address) {
                throw PassGenerationFailure.missingEntrantInformation(failedData)
            }
            let display: EntrantInformationDisplayable = PassDisplay(name:entrant.fullName(), entrantTypeDescription:"Ride services Employee Pass")
            let rideEmployeePass: RideServiceEmployeePass = RideServiceEmployeePass(withPassNumber: (entrantCount + 1), displayableDataSource: display)
            parkEntrant = Entrant(withPass: rideEmployeePass, entrantType: entrantType, entrantNumber: (entrantCount + 1))
            
            
        case let .employee(.maintenance(entrant, address)):
            if let failedData = missingEntrantInfoString(fromEntrant: entrant, entrantAddress: address) {
                throw PassGenerationFailure.missingEntrantInformation(failedData)
            }
            let display: EntrantInformationDisplayable = PassDisplay(name:entrant.fullName(), entrantTypeDescription:"Maintenance Employee Pass")
            let maintenanceEmployeePass: MaintenanceEmployeePass = MaintenanceEmployeePass(withPassNumber: (entrantCount + 1), displayableDataSource: display)
            parkEntrant = Entrant(withPass: maintenanceEmployeePass, entrantType: entrantType, entrantNumber: (entrantCount + 1))
            
        case let .manager(entrant, address):
            if let failedData = missingEntrantInfoString(fromEntrant: entrant, entrantAddress: address) {
                throw PassGenerationFailure.missingEntrantInformation(failedData)
            }
            let display: EntrantInformationDisplayable = PassDisplay(name:entrant.fullName(), entrantTypeDescription:"Manager Pass")
            let managerPass: ManagerPass = ManagerPass(withPassNumber: (entrantCount + 1), displayableDataSource: display)
            parkEntrant = Entrant(withPass: managerPass, entrantType: entrantType, entrantNumber: (entrantCount + 1))
            
            
        }
        
        
        if parkEntrant?.pass.areasAccessible.isEmpty == true || parkEntrant?.pass.discountPrivileges.isEmpty == true || parkEntrant?.pass.ridePrivileges.isEmpty == true {
            
            throw PassGenerationFailure.passGenerationFailed
        }
        
        return parkEntrant!
        
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
    
    
    
    func createAmusementParkEntrants() {
        
        
        /*let firstVipGuest: Entrant = Entrant(withEntrantType: .guest(.vip), entrantNumber: 1)
        let vipPass: VIPPass = VIPPass(withPassNumber: firstVipGuest.entrantNumber)
        firstVipGuest.pass = vipPass
        
        let foodEmployeeEntrant: EntrantType = EntrantType.employee(.foodServices(PersonName(firstName:"Gundu", lastName:"Rasgulla"), Address(streetAddress:"KS", city:"BLR", state: nil, zipCode: "560078")))
        let foodEmployee: Entrant = Entrant(withEntrantType: foodEmployeeEntrant, entrantNumber: 2)
        
        switch foodEmployee.type {
            case let .employee(.foodServices(name, addr)): print("name: \(name), address: \(addr)")
            default: print("")
            
        }*/
        
        
        /*do {
            let foodDiscount: Int? = try kioskManager.swipeForFoodWith(pass: firstVipGuest.pass!)
            if let foodDiscount = foodDiscount {
                //check birthday
                print("DISCOUNT ON FOOD: \(foodDiscount)")
            }
            else {
                print("Sorry, you do not have any food coupons on your pass.")
            }
        }
        catch ParkError.passGenerationError {
            print("Pass not generated properly. Please contact staff.")
        }
        catch ParkError.requestingUnknownLocationAccess {
            print("You are requesting access to an unknown location.")
        }
        catch {
            print("An unknown error has occurred.")
        }*/
        
        
        /*do {
            let merchandiseDiscount: Int? = try kioskManager.swipeForMerchandiseWith(pass: firstVipGuest.pass!)
            if let merchandiseDiscount = merchandiseDiscount {
                print("DISCOUNT ON MERCHANDISE: \(merchandiseDiscount)")
            }
            else {
                print("Sorry, you do not have any merchandise coupons on your pass.")
            }
        }
        catch ParkError.passGenerationError {
            print("Pass not generated properly. Please contact staff.")
        }
        catch ParkError.requestingUnknownLocationAccess {
            print("You are requesting access to an unknown location.")
        }
        catch {
            print("An unknown error has occurred.")
        }*/
        
        
        
    }
}
