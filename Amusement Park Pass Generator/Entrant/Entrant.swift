//
//  Entrant.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum EntrantType {
    
    case guest (GuestType)
    case employee (EmployeeType)
    case manager (PersonName, Address)
    
    func nameOfEntrant() -> PersonName? {
        
        switch self {
            
            case let .employee(.foodServices(name, _)): return name
            case let .employee(.rideServices(name, _)): return name
            case let .employee(.maintenance(name, _)):  return name
            case let .manager((name, _)): return name
            default: return nil
       
        }
    }
    
    func addressOfEntrant() -> Address? {
        
        switch self {
            
            case let .employee(.foodServices(_, address)): return address
            case let .employee(.rideServices(_, address)): return address
            case let .employee(.maintenance(_, address)):  return address
            case let .manager((_, address)): return address
            default: return nil
            
        }
        
    }
    
    func passTypeString() -> String {
        
        switch self {
            
            case .employee(.foodServices(_, _)): return "Food service employee pass"
            case .employee(.rideServices(_, _)): return "Ride service employee pass"
            case .employee(.maintenance(_, _)):  return "Maintenance service employee pass"
            case .manager((_, _)): return "Manager pass"
            case .guest(.classic): return "Classic guest pass"
            case .guest(.vip): return "VIP guest pass"
            case .guest(.freeChild): return "Child guest pass"
            
            //This is for part 2 of the app.
            /*case .guest(.seasonPassGuest(_, _)): return "Season guest pass"
            case .guest(.seniorGuest(_, dateOfBirth: _)): return "Senior guest pass"*/


        }
    }
}


enum GuestType {
    case classic
    case vip
    case freeChild (dateOfBirth: Date)
    
    //This is for part 2 of the app.
    /*case seasonPassGuest (PersonName, Address)
    case seniorGuest (PersonName, dateOfBirth: Date)*/
}


enum EmployeeType  {
    case foodServices (PersonName, Address)
    case rideServices (PersonName, Address)
    case maintenance (PersonName, Address)
    
    //This is for part 2 of the app.
    /*case contract (PersonName, Address)*/
}


class Entrant {
    
    var entrantNumber: Int = 0
    
    let type: EntrantType
    
    init(withType entrantType: EntrantType, entrantNumber: Int) {
        
        type = entrantType
        self.entrantNumber = entrantNumber

    }
}
