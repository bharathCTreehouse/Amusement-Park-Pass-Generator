//
//  ViewController.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 05/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let kioskManager: AccessKioskManager = AccessKioskManager()
    let entranceManager: ParkEntranceManager = ParkEntranceManager()
    
    var classicGuest: Entrant? = nil
    var vipGuest: Entrant? = nil
    var childGuest: Entrant? = nil
    
    var foodEmployee: Entrant? = nil
    var rideEmployee: Entrant? = nil
    var maintenanceEmployee: Entrant? = nil
    
    var manager: Entrant? = nil

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generatePass()
        
    }
    
    func generatePass() {
        //Collect all the data from UI and first create EntrantType. Pass this EntrantType to the entrance manager who will validate data and return the Entrant object with the pass assigned to it.
        
        //classic guest
        let classicGuestType: EntrantType = EntrantType.guest(.classic)
        if let entr = entrantForType(classicGuestType) {
            classicGuest = entr
        }
        
        //vip guest
        let vipGuestType: EntrantType = EntrantType.guest(.vip)
        if let entr = entrantForType(vipGuestType) {
            vipGuest = entr
        }
        
        //child guest
        let childGuestType: EntrantType = EntrantType.guest(.freeChild(Date()))
        if let entr = entrantForType(childGuestType) {
            childGuest = entr
        }
        
        
        //food employee
        let foodEmployeeType: EntrantType = EntrantType.employee(.foodServices(PersonName(firstName:"vv", lastName:"xxx"), Address(streetAddress:"India", city:"BLR", state:nil, zipCode:nil)))
        if let entr = entrantForType(foodEmployeeType) {
            foodEmployee = entr
        }
        else {
            print("Fail!!!")
        }
        
        
    }
    
    
    
    func entrantForType(_ type: EntrantType) -> Entrant? {
        
        var entrant: Entrant? = nil
        do {
            entrant = try entranceManager.entrant(forType: type)
        }
        catch let PassGenerationFailure.missingEntrantInformation(missingField) {
            print("\(missingField) is invalid/missing.")
        }
        catch PassGenerationFailure.passGenerationFailed {
            print("Failed to generate pass.")
        }
        catch {
            print("Unknown error.")
        }
        return entrant
        
    }
    
 


}

