//
//  EntrantAddressTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 15/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class EntrantAddressTableViewCell: UITableViewCell {
    
    @IBOutlet var streetAddressTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    @IBOutlet var zipCodeTextField: UITextField!
    
    private(set) var entrantAddress: Address? = Address(streetAddress:"", city:"", state:nil, zipCode: nil) {
        
        didSet {
            if entrantAddress == nil {
                streetAddressTextField.text = nil
                stateTextField.text = nil
                cityTextField.text = nil
                zipCodeTextField.text = nil
            }
        }
    }



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        streetAddressTextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        zipCodeTextField.delegate = self

    }
    
    
    
    func resetAddress() {
        entrantAddress = nil
    }
    
    
    func enableAddressCell(_ enable: Bool) {
        
        UIView.animate(withDuration: 0.6) {
            
            if enable == true {
                self.contentView.alpha = 1.0
            }
            else {
                self.contentView.alpha = 0.1
            }
            self.contentView.isUserInteractionEnabled = enable
            self.resetAddress()
        }
        
    }
    
    
    
    deinit {
        streetAddressTextField = nil
        cityTextField = nil
        stateTextField = nil
        zipCodeTextField = nil
        entrantAddress = nil
    }

    
    
}


extension EntrantAddressTableViewCell: UITextFieldDelegate {
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let newText = textField.text else {
            return
        }
        
        if textField == streetAddressTextField {
            entrantAddress?.updateStreetAddress(withString: newText)
        }
        else if textField == cityTextField {
            entrantAddress?.updateCity(withString: newText)
        }
        else if textField == stateTextField {
            entrantAddress?.updateState(withString: newText)
        }
        else if textField == zipCodeTextField {
            entrantAddress?.updateZipCode(withString: newText)
        }
        
    }
}
