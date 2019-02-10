//
//  ViewController.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 05/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var missingInfoSwitch: UISwitch!
    @IBOutlet weak var passGenerationStatusLabel: UILabel!
    @IBOutlet weak var accessStatusLabel: UILabel!
    @IBOutlet weak var specialMessageLabel: UILabel!

    let kioskManager: AccessKioskManager = AccessKioskManager()
    let entranceManager: ParkEntranceManager = ParkEntranceManager()
    var entrantPass: AccessDataSource? = nil {
        
        didSet {
            updateSpecialMessageLabel(withText: nil)
            accessStatusLabel.text = nil
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    deinit {
        missingInfoSwitch = nil
        passGenerationStatusLabel = nil
        accessStatusLabel = nil
        specialMessageLabel = nil
        entrantPass = nil
    }
    
}


//Pass generation
extension ViewController {
    
    /*Data for this method ideally should come from the UI, which shall be implemented in the second part of this project. For now, all the user information is hardcoded. */
    
    
    @IBAction func generatePassButtonTapped(_ sender: UIButton) {
        
        
        var typeOfEntrant: EntrantType? = nil
        
        
        switch sender.tag {
            
            //Classic guest
            case 1: typeOfEntrant = EntrantType.guest(.classic)
            
            
            //VIP guest
            case 2: typeOfEntrant = EntrantType.guest(.vip)
            
            
            //Free child guest (The child has to be below 5 years of age)
            case 3:
                let bDateFormatter: DateFormatter = DateFormatter()
                bDateFormatter.dateFormat = "MMM d, yyyy"
                
                //Valid date but not his birthday (Uncomment this to set a valid date but not his birthdate)
                //let bDate: Date? = bDateFormatter.date(from: "Feb 1, 2017")
                
                //Invalid date (Uncomment this to see if an appropriate error is shown during pass generation)
                //let bDate: Date? = bDateFormatter.date(from: "Mar 20, 2010")
                
                //Today is his birthday.(Uncomment this and put today's date to see a birthday wish on swiping at a counter where he has access.)
                let bDate: Date? = bDateFormatter.date(from: "Feb 11, 2017")

                typeOfEntrant = EntrantType.guest(.freeChild(dateOfBirth: bDate!))
            
            
            //Employee-food
            case 4:
                let fName: String = (self.missingInfoSwitch.isOn == true) ? "":"abc"
                typeOfEntrant =
                    EntrantType.employee(.foodServices(PersonName(firstName:fName, lastName:"xxx"), Address(streetAddress:"India", city:"BLR", state:nil, zipCode:nil)))
            
            
            //Employee-ride services
            case 5:
                let lName: String = (self.missingInfoSwitch.isOn == true) ? "$#&":"xxx"
                typeOfEntrant = EntrantType.employee(.rideServices(PersonName(firstName:"ddd", lastName:lName), Address(streetAddress:"India", city:"BLR", state:nil, zipCode:nil)))
            
            
            //Employee-maintenance
            case 6:
                let street: String = (self.missingInfoSwitch.isOn == true) ? "":"India"
                typeOfEntrant = EntrantType.employee(.maintenance(PersonName(firstName:"ddd", lastName:"xxx"), Address(streetAddress:street, city:"BLR", state:nil, zipCode:nil)))
            
            
            //Employee-manager
            case 7:
                let city: String = (self.missingInfoSwitch.isOn == true) ? "":"BLR"
                typeOfEntrant = EntrantType.manager(PersonName(firstName:"ddd", lastName:"xxx"), Address(streetAddress:"India", city:city, state:nil, zipCode:nil))
            
            default: break
            
        }
        
        self.entrantPass = passForType(typeOfEntrant!)
        
    }
    
    
    func passForType(_ type: EntrantType) -> AccessDataSource? {
        
        var pass: AccessDataSource? = nil
        do {
            pass = try entranceManager.pass(forEntrantType: type)
            self.passGenerationStatusLabel.text = "Pass generated successfully \n" + ((pass as? PersonalInformationDataSource)?.passTypeDescription)!
        }
        catch let PassGenerationFailure.passGenerationFailed(reason) {
            self.passGenerationStatusLabel.text = "Failed to generate pass: \(reason)"
        }
        catch {
            self.passGenerationStatusLabel.text = "Failed to generate pass: An unknown error has occurred. Please try generating again."
        }
        return pass
        
    }
}



//This will probably move to a different view controller in the second part of the project.
//Swiping
extension ViewController {
    
    
    @IBAction func swipeButtonTapped(_ sender: UIButton) {
        
        
        updateSpecialMessageLabel(withText: nil)

        
        if entrantPass == nil {
            return
        }
        
        
        do {
            switch sender.tag {
                
                case 8:
                    let hasAccess = try kioskManager.swipe(pass: entrantPass!, atArea: .amusement)
                    handleAccess(toArea: .amusement, withPermissionGrant: hasAccess)

                case 9:
                    let hasAccess = try kioskManager.swipe(pass: entrantPass!, atArea: .kitchen)
                    handleAccess(toArea: .kitchen, withPermissionGrant: hasAccess)
                
                case 10:
                    let hasAccess = try kioskManager.swipe(pass: entrantPass!, atArea: .rideControl)
                    handleAccess(toArea: .rideControl, withPermissionGrant: hasAccess)
                
                case 11:
                    let hasAccess = try kioskManager.swipe(pass: entrantPass!, atArea: .maintenance)
                    handleAccess(toArea: .maintenance, withPermissionGrant: hasAccess)

                case 12:
                    let hasAccess = try kioskManager.swipe(pass: entrantPass!, atArea: .office)
                    handleAccess(toArea: .office, withPermissionGrant: hasAccess)

                
                
                case 13:
                    let rideAccess: (Bool,Bool) = try kioskManager.swipeForRideWith(pass: entrantPass!)
                    handleAccessToRide(withPermsissionDetails: rideAccess)
                
                case 14:
                    let foodDiscount: Int? = try kioskManager.swipeForFoodWith(pass: entrantPass!)
                    handleAccessToFoodCounter(withDiscountPrivilege: foodDiscount)
                
                case 15:
                    let merchandiseDiscount: Int? = try kioskManager.swipeForMerchandiseWith(pass: entrantPass!)
                    handleAccessToMerchandiseCounter(withDiscountPrivilege: merchandiseDiscount)
                
                default: break
                
            }
           
        }
        
        catch let error as ParkError {
            self.accessStatusLabel.text = error.userDisplayString()
        }
        catch {
            self.accessStatusLabel.text = ParkError.unknown.userDisplayString()
        }
        
    }
    
    
    func handleAccess(toArea area: AreaAccess, withPermissionGrant granted: Bool) {
        
        if granted ==  true {
            
            //Permission granted. User has access.
            self.accessStatusLabel.text = "Access granted! \(area.areaAccessString())"
            
            //Check for birthday only when entrant has access to the requested area.
            checkForBirthday()

        }
        else {
            //No permission.
            self.accessStatusLabel.text = "Access denied! \(AreaAccess.undefined.areaAccessString())"
            
        }
        
    }
    
    
    func handleAccessToRide(withPermsissionDetails details: (hasAccess: Bool, canSkipLines: Bool)) {
        
        if details.hasAccess == true {
            
            //Access granted.
            var userText: String = "Access granted! \(RideAccess.all.rideAccessString())"
            if details.canSkipLines == true {
                userText = userText + ". \(RideAccess.skipRideLines.rideAccessString())"
            }
            self.accessStatusLabel.text = userText
            
            //Check for birthday only when entrant has access to the requested area.
            checkForBirthday()
        }
        else {
            //No access to rides.
            self.accessStatusLabel.text = "Access denied! \(RideAccess.undefined.rideAccessString())"

        }
        
    }
    
    
    func handleAccessToFoodCounter(withDiscountPrivilege percentage: Int?) {
        
        if percentage != nil {
            //Entrant has a discount on food.
            handleAccessTo(discountArea: .food(percentage!))
            checkForBirthday()
        }
        else {
            //No discount on food.
            handleAccessTo(discountArea: .none)

        }
    }
    
    
    func handleAccessToMerchandiseCounter(withDiscountPrivilege percentage: Int?) {
        
        if percentage != nil {
            //Entrant has a discount on merchandise.
            handleAccessTo(discountArea: .merchandise(percentage!))
            checkForBirthday()
        }
        else {
            //No discount on merchandise.
            handleAccessTo(discountArea: .none)

        }
    }
    
    
    func handleAccessTo(discountArea area: Discount) {
        self.accessStatusLabel.text = area.discountString()
    }
    
}



//Birthday related UI updates.
extension ViewController {
    
    
    func checkForBirthday() {
        
        guard let birthWisherPass = (entrantPass as? PersonalInformationReminder) else {
            
            //No birthDate information collected. No point checking further.
            return
        }
        
        let isBirthday: Bool? = kioskManager.isTodayBirthdayOfEntrant(withPass: birthWisherPass)
        
        if isBirthday != nil {
            
            if isBirthday == true {
                updateSpecialMessageLabel(withText: "A very happy birthday to you. Wishing you many many more!")
            }
            
        }
        
    }
    
    
    
    
    func updateSpecialMessageLabel(withText text: String?) {
        self.specialMessageLabel.text = text

    }
    
}

