//
//  EntrantAddressTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 15/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class EntrantAddressTableViewCell: EntrantInformationTableViewCell {
    
    @IBOutlet private(set) var streetAddressTextField: UITextField!
    @IBOutlet private(set) var cityTextField: UITextField!
    @IBOutlet private(set) var stateTextField: UITextField!
    @IBOutlet private(set) var zipCodeTextField: UITextField!
    
    private(set) var entrantAddressDataSource: EntrantAddressDataSource? = nil {
        
        didSet {
            
            streetAddressTextField.text = entrantAddressDataSource?.address?.streetAddress
            cityTextField.text = entrantAddressDataSource?.address?.city
            stateTextField.text = entrantAddressDataSource?.address?.state
            zipCodeTextField.text = entrantAddressDataSource?.address?.zipCode
            
        }
    }
    
    
    
    func updateDataSource(with dataSource: EntrantAddressDataSource) {
        entrantAddressDataSource = dataSource
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        streetAddressTextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        zipCodeTextField.delegate = self

    }
    
    
    
    deinit {
        streetAddressTextField = nil
        cityTextField = nil
        stateTextField = nil
        zipCodeTextField = nil
        entrantAddressDataSource = nil
    }

}




extension EntrantAddressTableViewCell: UITextFieldDelegate {
    
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let newText = textField.text else {
            return
        }
        
        if textField == streetAddressTextField {
            entrantAddressDataSource?.updateStreetAddress(withString: newText)
        }
        else if textField == cityTextField {
            entrantAddressDataSource?.updateCity(withString: newText)
        }
        else if textField == stateTextField {
            entrantAddressDataSource?.updateState(withString: newText)
        }
        else if textField == zipCodeTextField {
            entrantAddressDataSource?.updateZipCode(withString: newText)
        }
        
    }
    
}
