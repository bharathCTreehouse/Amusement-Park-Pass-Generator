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
    
    var shouldResetData: Bool = false

    
    var entrantType: EntrantTypeUIIdentifier {
        didSet {
            shouldResetData = true
            endEditing(true)
            reloadData()
        }
    }
    
    
    
    init(withTableViewStyle style: Style, entrantType: EntrantTypeUIIdentifier) {
        
        self.entrantType = entrantType
        super.init(frame: .zero, style: style)
        dataSource = self
        
        register(UINib.init(nibName: "EntrantNameTableViewCell", bundle: .main), forCellReuseIdentifier: "entrantNameCell")
        
        register(UINib.init(nibName: "EntrantAddressTableViewCell", bundle: .main), forCellReuseIdentifier: "entrantAddressCell")
        
        register(UINib.init(nibName: "EntrantCompanyInfoTableViewCell", bundle: .main), forCellReuseIdentifier: "entrantCompanyCell")

        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 44.0
        translatesAutoresizingMaskIntoConstraints = false
        
        (self as UIScrollView).delegate = self
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
        
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: EntrantInformationTableViewCell
        
        if indexPath.row == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "entrantNameCell", for: indexPath) as! EntrantInformationTableViewCell
            cell.enable(entrantType.requiresName(), view: cell.contentView)
           
        }
        else if indexPath.row == 1 {
            
             cell = tableView.dequeueReusableCell(withIdentifier: "entrantCompanyCell", for: indexPath) as! EntrantInformationTableViewCell
             cell.enable(entrantType.requiresCompanyName(), view: cell.contentView)
        
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "entrantAddressCell", for: indexPath) as! EntrantInformationTableViewCell
            cell.enable(entrantType.requiresAddress(), view: cell.contentView)
            
        }
        
        if shouldResetData == true {
            cell.resetData()
        }
        
        return cell
        
    }
    
}




extension EntrantInformationTableView: UIScrollViewDelegate {
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        shouldResetData = false

    }
}
