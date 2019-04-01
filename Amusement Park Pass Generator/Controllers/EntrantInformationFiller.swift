//
//  EntrantInformationFiller.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 01/04/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class EntrantInformationFiller {
    
    
    static func populateEntrantInfo(onTableView entrantInfoTableView: EntrantInformationTableView) {
        
        
        let entrantType =  entrantInfoTableView.entrantType
       
        
        if entrantType.requiresDateOfBirth() == true {
            
            //Child
            var sampleDob: Date? = "12/10/2017".date(withFormat: "MM/dd/yyyy")
            
            if entrantType == .seniorGuest {
                sampleDob = "12/10/1955".date(withFormat: "MM/dd/yyyy")
            }
            else if entrantType == .vendor {
                sampleDob = "12/10/2001".date(withFormat: "MM/dd/yyyy")
            }
            if let sampleDob = sampleDob {
        
                entrantInfoTableView.miscInformationDataSource.updateBirthDate(with: sampleDob)
            }
        }
        if entrantType.requiresProjectNumber() == true {
            entrantInfoTableView.miscInformationDataSource.updateProject(with: .project_1002)
        }
        if entrantType.requiresName() == true {
            entrantInfoTableView.nameDataSource.updateFirstName(with: "Bharath")
            entrantInfoTableView.nameDataSource.updateLastName(with: "Chandrashekar")
        }
        if entrantType.requiresCompanyName() == true {
            entrantInfoTableView.companyDataSource.updateCompany(with: .nwElectrical)
        }
        if entrantType.requiresAddress() == true {
            entrantInfoTableView.addressDataSource.updateCity(withString: "Bangalore")
            entrantInfoTableView.addressDataSource.updateState(withString: "Karnataka")
            entrantInfoTableView.addressDataSource.updateZipCode(withString: "560078")
            entrantInfoTableView.addressDataSource.updateStreetAddress(withString: "MG road")
        }
        
        
        entrantInfoTableView.reloadData()
        
    }
    
}
