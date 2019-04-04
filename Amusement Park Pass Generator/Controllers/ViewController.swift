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
    var entrantPass: AccessDataSource? = nil

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //Entrant type selection view
        let entrantTypeView: EntrantTypeSelectionView = EntrantTypeSelectionView(withEntrantTypeSelectionDelegate: self)
        view.addSubview(entrantTypeView)
        entrantTypeView.configure(withConstraints: [.leading(referenceConstraint: view.leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .trailing(referenceConstraint: view.trailingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .top(referenceConstraint: view.topAnchor, constantOffSet: 44.0, equalityType: .equalTo)])
        
       

        //Pass generation/Data population view
        let passGenerationView: PassGenerationView = PassGenerationView { [unowned self] (option: PassGenerationOption) in
            
            if option == .generatePass {
                self.generatePass()
            }
            else if option == .populateData {
                self.populateData()
            }
        }
        view.addSubview(passGenerationView)
        passGenerationView.configure(withConstraints: [.leading(referenceConstraint: view.leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .trailing(referenceConstraint: view.trailingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .bottom(referenceConstraint: view.bottomAnchor, constantOffSet: 0.0, equalityType: .equalTo)])
        
       
        //Table view
        entrantInfoTableView = EntrantInformationTableView(withTableViewStyle: .grouped, entrantType: .classicGuest)
        view.addSubview(entrantInfoTableView!)
        entrantInfoTableView!.configure(withConstraints: [.leading(referenceConstraint: view.leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .trailing(referenceConstraint: view.trailingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .top(referenceConstraint: entrantTypeView.bottomAnchor, constantOffSet: 40.0, equalityType: .equalTo), .bottom(referenceConstraint: passGenerationView.topAnchor, constantOffSet: 0.0, equalityType: .equalTo)])
        
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
        
        
        //Gather data from the UI.
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
        }
        catch let PassGenerationFailure.passGenerationFailed(reason) {
            showAlert(withMessage: "Failed to generate pass: \(reason).")
        }
        catch {
            showAlert(withMessage: "Failed to generate pass: An unknown error has occurred. Please try generating again.")
        }
        return pass
        
    }
}



//Date population
extension ViewController {
    
    func populateData() {
        
        guard let _ =  entrantInfoTableView?.entrantType else {
            return
        }
        EntrantInformationFiller.populateEntrantInfo(onTableView: entrantInfoTableView!)
        
    }
    
    
}



extension ViewController {
    
    func showAlert(withMessage alertMessage: String) {
        
        AmusementParkAlertController.showAlertController(forViewController: self, handler: nil, listOfButtonTitles: ["OK"], alertTitle: "Error", alertMessage: alertMessage)
    }
    
}









