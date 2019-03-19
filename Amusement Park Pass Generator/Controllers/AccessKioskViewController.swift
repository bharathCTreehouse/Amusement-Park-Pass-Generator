//
//  AccessKioskViewController.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 17/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class AccessKioskViewController: UIViewController {
    
    let kioskManager: AccessKioskManager = AccessKioskManager()
    var entrantPass: AccessDataSource? = nil
    var accessKioskTableView: AccessKioskTableView? = nil
    
    
    init(withEntrantPass pass: AccessDataSource) {
        entrantPass = pass
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func loadView() {
        
        self.view = UIView()
        
        accessKioskTableView = AccessKioskTableView(withAccessTestingCompletionHandler: { (kioskIdentifier: Int) in
            
            print(kioskIdentifier)
        }, displayableDataSource: entrantPass as! PersonalInformationDataSource)
        
        view.addSubview(accessKioskTableView!)
        accessKioskTableView!.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        accessKioskTableView!.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        accessKioskTableView!.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        accessKioskTableView!.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    deinit {
        entrantPass = nil
        accessKioskTableView = nil
    }
    
    
}


//Swiping
extension AccessKioskViewController {
    
    
    @IBAction func swipeButtonTapped(_ sender: UIButton) {
        
        
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
            //self.accessStatusLabel.text = error.userDisplayString()
        }
        catch {
            //self.accessStatusLabel.text = ParkError.unknown.userDisplayString()
        }
        
    }
    
    
    func handleAccess(toArea area: AreaAccess, withPermissionGrant granted: Bool) {
        
        if granted ==  true {
            
            //Permission granted. User has access.
            //self.accessStatusLabel.text = "Access granted! \(area.areaAccessString())"
            
            //Check for birthday only when entrant has access to the requested area.
            checkForBirthday()
            
        }
        else {
            //No permission.
            //self.accessStatusLabel.text = "Access denied! \(AreaAccess.undefined.areaAccessString())"
            
        }
        
    }
    
    
    func handleAccessToRide(withPermsissionDetails details: (hasAccess: Bool, canSkipLines: Bool)) {
        
        if details.hasAccess == true {
            
            //Access granted.
            var userText: String = "Access granted! \(RideAccess.all.rideAccessString())"
            if details.canSkipLines == true {
                userText = userText + ". \(RideAccess.skipRideLines.rideAccessString())"
            }
            //self.accessStatusLabel.text = userText
            
            //Check for birthday only when entrant has access to the requested area.
            checkForBirthday()
        }
        else {
            //No access to rides.
            //self.accessStatusLabel.text = "Access denied! \(RideAccess.undefined.rideAccessString())"
            
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
        //self.accessStatusLabel.text = area.discountString()
    }
    
    
}



//Birthday related UI updates.
extension AccessKioskViewController {
    
    
    func checkForBirthday() {
        
        guard let birthWisherPass = (entrantPass as? PersonalInformationReminder) else {
            
            //No birthDate information collected. No point checking further.
            return
        }
        
        let isBirthday: Bool? = kioskManager.isTodayBirthdayOfEntrant(withPass: birthWisherPass)
        
        if isBirthday != nil {
            
            if isBirthday == true {
                //updateSpecialMessageLabel(withText: "A very happy birthday to you. Wishing you many many more!")
            }
            
        }
        
    }
    
}
