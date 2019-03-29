//
//  ViewController.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 05/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    var entrantInfoTableView: EntrantInformationTableView? = nil
    let entranceManager: ParkEntranceManager = ParkEntranceManager()
    var entrantPass: AccessDataSource? = nil {
        
        didSet {
            //updateSpecialMessageLabel(withText: nil)
            //accessStatusLabel.text = nil
        }
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //Entrant type selection view
        let entrantTypeView: EntrantTypeSelectionView = EntrantTypeSelectionView(withEntrantTypeSelectionDelegate: self)
        view.addSubview(entrantTypeView)
        entrantTypeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        entrantTypeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        entrantTypeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44.0).isActive = true

        
        
        //Pass generation/Data population view
        let passGenerationView: PassGenerationView = PassGenerationView { [unowned self] (option: PassGenerationOption) in
            
            self.generatePass()
        }
        view.addSubview(passGenerationView)
        passGenerationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        passGenerationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        passGenerationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        //Table view
        entrantInfoTableView = EntrantInformationTableView(withTableViewStyle: .grouped, entrantType: .classicGuest)
        view.addSubview(entrantInfoTableView!)
        entrantInfoTableView!.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        entrantInfoTableView!.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        entrantInfoTableView!.topAnchor.constraint(equalTo: entrantTypeView.bottomAnchor, constant: 40.0).isActive = true
        entrantInfoTableView!.bottomAnchor.constraint(equalTo: passGenerationView.topAnchor).isActive = true
        
    }
    
    
    deinit {
        entrantPass = nil
        entrantInfoTableView = nil
    }
    
}


extension ViewController: EntrantTypeSelectionProtocol {
    
    func didFinishSelectingEntrantType(_ type: EntrantTypeUIIdentifier) {
        entrantInfoTableView?.entrantType = type
    }

}



//Pass generation
extension ViewController {
    
    
    func generatePass() {
        
        
        let dateOfBirth: Date? = entrantInfoTableView?.miscInformationDataSource.dateOfBirth
        let project: ProjectRegistered? = entrantInfoTableView?.miscInformationDataSource.project
        let name: PersonName? = entrantInfoTableView?.nameDataSource.entrantName
        let company: CompaniesRegistered? = entrantInfoTableView?.companyDataSource.company
        let dateOfVisit: Date? = entrantInfoTableView?.companyDataSource.dateOfVisit
        let address: Address? = entrantInfoTableView?.addressDataSource.address
        
        
        
        var typeOfEntrant: EntrantType? = nil
        
        
        switch entrantInfoTableView!.entrantType {
            
            //Classic guest
            case .classicGuest: typeOfEntrant = EntrantType.guest(.classic)
            
            
            //VIP guest
            case .vipGuest: typeOfEntrant = EntrantType.guest(.vip)
            
            
            //Free child guest (The child has to be below 5 years of age)
            case .childGuest:
                typeOfEntrant = EntrantType.guest(.freeChild(dateOfBirth: dateOfBirth))
            
            
            //Season guest
            case .seasonGuest:
                typeOfEntrant = EntrantType.guest(.seasonPassGuest(name, address))
            
            
            //Senior guest (Must be 60 or above)
            case .seniorGuest:
                typeOfEntrant = EntrantType.guest(.seniorGuest(name, dateOfBirth: dateOfBirth))
            
            
            //Employee-food
            case .foodServiceEmployee:
                typeOfEntrant =
                    EntrantType.employee(.foodServices(name, address))
            
            
            //Employee-ride services
            case .rideServiceEmployee:
                typeOfEntrant = EntrantType.employee(.rideServices(name, address))
            
            
            //Employee-maintenance
            case .maintenanceEmployee:
                typeOfEntrant = EntrantType.employee(.maintenance(name, address))
            
            
            //Employee-contract
            case .contractEmployee:
                typeOfEntrant = EntrantType.employee(.contract(name, address, project))
            
            
            //Manager
            case .manager:
                typeOfEntrant = EntrantType.manager(name, address)
            
            
            //Vendor
            case .vendor:
                typeOfEntrant = EntrantType.vendor(name, company, dateOfBirth: dateOfBirth, dateOfVisit: dateOfVisit)
            
            
        }
        
        self.entrantPass = passForType(typeOfEntrant!)
        
        
        if entrantPass != nil {
            let kioskViewController: AccessKioskViewController = AccessKioskViewController(withEntrantPass: entrantPass!)
            present(kioskViewController, animated: true, completion: nil)
        }
        
    }
    
    
    func passForType(_ type: EntrantType) -> AccessDataSource? {
        
        var pass: AccessDataSource? = nil
        do {
            pass = try entranceManager.pass(forEntrantType: type)
            print("Pass generated successfully")
            print("\(String(describing: ((pass as? PersonalInformationDataSource)?.passTypeDescription)))")
        }
        catch let PassGenerationFailure.passGenerationFailed(reason) {
            print("Failed to generate pass: \(reason).")
        }
        catch {
            print("Failed to generate pass: An unknown error has occurred. Please try generating again.")
        }
        return pass
        
    }
}









