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
    let listOfCompanies: [String] = [CompaniesRegistered.acme.displayString, CompaniesRegistered.orkin.displayString, CompaniesRegistered.fedex.displayString, CompaniesRegistered.nwElectrical.displayString]
    
    
    var entrantCompanyName: String? = nil {
        
        didSet {
            
            if entrantCompanyName == nil {
                companyTextField.text = nil
            }
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        companyTextField.delegate = self
        
        companyTextField.inputView = SelectionPickerView(withPickerList: listOfCompanies)
        
        let toolBar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0.0, y: 0.0, width: frame.size.width, height: 55.0))
        let space: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped(_:)))
        toolBar.setItems([space,doneButton], animated: false)
        
        companyTextField.inputAccessoryView = toolBar

    }
    
    
    
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        endEditing(true)

        let picker: UIPickerView = (companyTextField.inputView as! SelectionPickerView).picker!
        companyTextField.text = listOfCompanies[picker.selectedRow(inComponent: 0)]
    }
    
    
    
    override func resetData() {
        entrantCompanyName = nil
    }
    
    
    deinit {
        entrantCompanyName = nil
        companyTextField = nil
    }

}



extension EntrantCompanyInfoTableViewCell: UITextFieldDelegate {
    
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let newText = textField.text else {
            return
        }
        
        if textField == companyTextField {
            entrantCompanyName = newText
        }
        
    }
    
}
