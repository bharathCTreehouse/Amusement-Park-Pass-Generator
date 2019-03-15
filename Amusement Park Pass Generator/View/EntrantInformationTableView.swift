//
//  EntrantInformationTableView.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 13/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


enum EntrantTypeUIIdentifier {
    
    case classicGuest
    case vipGuest
    case childGuest
    case seasonGuest
    case seniorGuest
    case foodServiceEmployee
    case rideServiceEmployee
    case maintenanceEmployee
    case contractEmployee
    case manager
    case vendor
    
    
    private var entrantTypesRequiringName: [EntrantTypeUIIdentifier] {
        return [.seasonGuest, .seniorGuest, .foodServiceEmployee, .rideServiceEmployee, .maintenanceEmployee, .contractEmployee, .manager, .vendor]
    }
    
    private var entrantTypesRequiringAddress: [EntrantTypeUIIdentifier] {
        return [.seasonGuest, .foodServiceEmployee, .rideServiceEmployee, .maintenanceEmployee, .contractEmployee, .manager]
    }
    
    private var entrantTypesRequiringCompanyName: [EntrantTypeUIIdentifier] {
        return [.vendor]
    }
    
    private var entrantTypesRequiringDateOfBirth: [EntrantTypeUIIdentifier] {
        return [.childGuest, .seniorGuest, .vendor]
    }
    
    private var entrantTypesRequiringProjectNumber: [EntrantTypeUIIdentifier] {
        return [.contractEmployee]
    }
    
    private var entrantTypesRequiringDateOfVisit: [EntrantTypeUIIdentifier] {
        return [.vendor]
    }
    
    
    func requiresName() -> Bool {
        return entrantTypesRequiringName.contains(self)
    }
    
    func requiresAddress() -> Bool {
        return entrantTypesRequiringAddress.contains(self)
    }
    
    func requiresCompanyName() -> Bool {
        return entrantTypesRequiringCompanyName.contains(self)
    }
    
    func requiresDateOfBirth() -> Bool {
        return entrantTypesRequiringDateOfBirth.contains(self)
    }
    
    func requiresDateOfLastVisit() -> Bool {
        return entrantTypesRequiringDateOfVisit.contains(self)
    }
    
    func requiresProjectNumber() -> Bool {
        return entrantTypesRequiringProjectNumber.contains(self)
    }
}



class EntrantInformationTableView: UITableView {
    
    
    var miscInformationDataSource: MiscEntrantInfoDataSource = MiscEntrantInfoDataSource()
    var nameDataSource: EntrantNameDataSource = EntrantNameDataSource()
    var companyDataSource: EntrantCompanyDataSource = EntrantCompanyDataSource()
    var addressDataSource: EntrantAddressDataSource = EntrantAddressDataSource()

    
    var entrantType: EntrantTypeUIIdentifier {
        
        didSet {
            
            endEditing(true)
            
            miscInformationDataSource.reset()
            nameDataSource.reset()
            companyDataSource.reset()
            addressDataSource.reset()
            
            reloadData()

        }
    }
    
    
    
    init(withTableViewStyle style: Style, entrantType: EntrantTypeUIIdentifier) {
        
        self.entrantType = entrantType
        super.init(frame: .zero, style: style)
        translatesAutoresizingMaskIntoConstraints = false

        configureTableView()
        setupKeyPadObservers()
        
        
    }
    
    
    func configureTableView() {
        
        dataSource = self

        register(UINib.init(nibName: "EntrantNameTableViewCell", bundle: .main), forCellReuseIdentifier: "entrantNameCell")
        
        register(UINib.init(nibName: "EntrantAddressTableViewCell", bundle: .main), forCellReuseIdentifier: "entrantAddressCell")
        
        register(UINib.init(nibName: "EntrantCompanyInfoTableViewCell", bundle: .main), forCellReuseIdentifier: "entrantCompanyCell")
        
        register(UINib.init(nibName: "MiscEntrantInformationTableViewCell", bundle: .main), forCellReuseIdentifier: "miscEntrantInfoCell")

        
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 44.0
        keyboardDismissMode = .onDrag

    }
    
    
   
    required init?(coder aDecoder: NSCoder) {
        entrantType = .classicGuest
        super.init(coder: aDecoder)
    }
    
}



extension EntrantInformationTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: EntrantInformationTableViewCell
        
        
        if indexPath.row == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "miscEntrantInfoCell", for: indexPath) as! EntrantInformationTableViewCell
            let miscCell:MiscEntrantInformationTableViewCell = cell as! MiscEntrantInformationTableViewCell
            cell.enable(entrantType.requiresDateOfBirth(), view: miscCell.dateOfBirthTextField)
            cell.enable(entrantType.requiresProjectNumber(), view: miscCell.projectNumberTextField)
            
            miscCell.updateDataSource(with: miscInformationDataSource)

        }
        
        else if indexPath.row == 1 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "entrantNameCell", for: indexPath) as! EntrantInformationTableViewCell
            cell.enable(entrantType.requiresName(), view: cell.contentView)
            
            let nameCell:EntrantNameTableViewCell = cell as! EntrantNameTableViewCell
            nameCell.updateDataSource(with: nameDataSource)

           
        }
        else if indexPath.row == 2 {
            
             cell = tableView.dequeueReusableCell(withIdentifier: "entrantCompanyCell", for: indexPath) as! EntrantInformationTableViewCell
             cell.enable(entrantType.requiresCompanyName(), view: cell.contentView)
            
            let companyCell:EntrantCompanyInfoTableViewCell = cell as! EntrantCompanyInfoTableViewCell
            companyCell.updateDataSource(with: companyDataSource)
        
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "entrantAddressCell", for: indexPath) as! EntrantInformationTableViewCell
            cell.enable(entrantType.requiresAddress(), view: cell.contentView)
            
            let addressCell:EntrantAddressTableViewCell = cell as! EntrantAddressTableViewCell
            addressCell.updateDataSource(with: addressDataSource)
            
        }
        
        
        return cell
        
    }
    
}



extension EntrantInformationTableView {
    
    
    func setupKeyPadObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillDisplay(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyBoardWillDisplay(_ notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
        
    }
    
    
    @objc func keyBoardWillHide(_ notification: NSNotification) {
        
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
