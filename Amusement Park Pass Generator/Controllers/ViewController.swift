//
//  ViewController.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 05/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var accessLabel: UILabel!
    
    let kioskManager: AccessKioskManager = AccessKioskManager()
    let entranceManager: ParkEntranceManager = ParkEntranceManager()
    
    var classicGuestPass: (AreaAccessDataSource & RideAccessDataSource & DiscountAccessDataSource)? = nil
    var vipGuestPass: (AreaAccessDataSource & RideAccessDataSource & DiscountAccessDataSource)? = nil
    var childGuestPass: (AreaAccessDataSource & RideAccessDataSource & DiscountAccessDataSource)? = nil
    
    var foodEmployeePass: (AreaAccessDataSource & RideAccessDataSource & DiscountAccessDataSource)? = nil
    var rideEmployeePass: (AreaAccessDataSource & RideAccessDataSource & DiscountAccessDataSource)? = nil
    var maintenanceEmployeePass: (AreaAccessDataSource & RideAccessDataSource & DiscountAccessDataSource)? = nil
    
    var managerPass: (AreaAccessDataSource & RideAccessDataSource & DiscountAccessDataSource)? = nil

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generatePass()
        swipe()
        
    }
    
    func generatePass() {
        //Collect all the data from UI and first create EntrantType. Pass this EntrantType to the entrance manager who will validate data and return the Entrant object with the pass assigned to it.
        
        //classic guest
        let classicGuestType: EntrantType = EntrantType.guest(.classic)
        if let pass = passForType(classicGuestType) {
            classicGuestPass = pass
        }
        
        //vip guest
        let vipGuestType: EntrantType = EntrantType.guest(.vip)
        if let pass = passForType(vipGuestType) {
            vipGuestPass = pass
        }
        
        //child guest
        let bDateFormatter: DateFormatter = DateFormatter()
        bDateFormatter.dateFormat = "MMM d, yyyy"
        let bDate: Date? = bDateFormatter.date(from: "Feb 04, 2016")
        let childGuestType: EntrantType = EntrantType.guest(.freeChild(bDate!))
        if let pass = passForType(childGuestType) {
            childGuestPass = pass
        }
        
        
        //food employee
        let foodEmployeeType: EntrantType = EntrantType.employee(.foodServices(PersonName(firstName:"vv", lastName:"xxx"), Address(streetAddress:"India", city:"BLR", state:nil, zipCode:nil)))
        if let pass = passForType(foodEmployeeType) {
            foodEmployeePass = pass
        }
        else {
            print("Fail!!!")
        }
        
        
    }
    
    
    
    func passForType(_ type: EntrantType) -> (AreaAccessDataSource & RideAccessDataSource & DiscountAccessDataSource)? {
        
        var pass: (AreaAccessDataSource & RideAccessDataSource & DiscountAccessDataSource)? = nil
        do {
            pass = try entranceManager.pass(forEntrantType: type)
        }
        catch let PassGenerationFailure.passGenerationFailed(reason) {
            print(reason)
        }
        catch {
            print("Unknown error.")
        }
        return pass
        
    }
    
}



//Swiping
extension ViewController {
    
    func swipe() {
        
        if childGuestPass == nil {
            return
        }
        
        do {
            let hasAccess: Bool = try kioskManager.swipe(pass: childGuestPass!, atArea: .amusement)
            if hasAccess == true {
                print("Access granted")
                print("\((childGuestPass as? PersonalInformationDataSource)?.passTypeDescription ?? "Unknown pass")")
                var str: String = ""
                for dis in childGuestPass!.discountPrivileges {
                    str = str + "\n" + dis.discountString()
                    //print(dis.discountString())
                }
                self.accessLabel.text = str
                guard let birthWisherPass = (childGuestPass as? PersonalInformationReminder) else {
                    //No birthDate entered. No point checking further.
                    return
                }
                let isBirthday: Bool? = kioskManager.isTodayBirthdayOfEntrant(withPass: birthWisherPass)
                if isBirthday != nil {
                    if isBirthday == true {
                        print("A very happy birthday to you. Wishing you many many more!")
                    }
                }
               
            }
            else {
                print("Sorry, no access")
            }
        }
        catch ParkError.passGenerationError {
            print("Pass not generated properly. Please contact admin.")
        }
        catch ParkError.requestingUnknownLocationAccess {
            print("You are trying to access an unknown location.")
        }
        catch ParkError.unknown {
            print("Unknown error has occurred.")
        }
        catch {
            print("Unknown error has occurred.")
        }
        
        
    }
    
}

