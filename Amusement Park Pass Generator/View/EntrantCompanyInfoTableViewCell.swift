//
//  EntrantCompanyInfoTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 22/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit
import Foundation


class EntrantCompanyInfoTableViewCell: EntrantInformationTableViewCell {
    
    @IBOutlet var companyTextField: UITextField!
    
    
    private var entrantCompany: CompaniesRegistered? = nil {
        
        didSet {
            companyTextField.text = entrantCompany?.displayString
        }
    }


    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        companyTextField.delegate = self

        companyTextField.inputView = SelectionPickerView(withPickerList: CompaniesRegistered.orderedDisplayableCompanyList(), completionHandler:
            
            { [unowned self] (selectedIndex: Int)  in
            
                self.companyTextField.delegate = nil
                self.entrantCompany = CompaniesRegistered.orderedCompanyList()[selectedIndex]
                self.endEditing(true)
                self.companyTextField.delegate = self
                
        })
        
    }
    
    
    
    override func resetData() {
        entrantCompany = nil
    }
    
    
    
    deinit {
        entrantCompany = nil
        companyTextField = nil
    }

}



extension EntrantCompanyInfoTableViewCell: UITextFieldDelegate {
    
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        let selectionView: SelectionPickerView? = (companyTextField?.inputView) as? SelectionPickerView
        
        if let selectionView = selectionView {
            selectionView.closeSelectionPickerView()
        }
        
    }
    
}
