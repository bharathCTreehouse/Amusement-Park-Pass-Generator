//
//  ViewController.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 05/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createAmusementParkEntrants()
    }
    
    func createAmusementParkEntrants() {
        
        let kioskManager: AccessKioskManager = AccessKioskManager()
        
        let firstVipGuest: Entrant = Entrant(withEntrantType: .guest(.vip), entrantNumber: 1)
        let vipPass: VIPPass = VIPPass(withPassNumber: firstVipGuest.entrantNumber)
        firstVipGuest.pass = vipPass
        
        
        do {
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
        }
        
        
        
        
        
        do {
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
        }
       
        
        
    }


}

