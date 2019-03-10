//
//  EntrantNameTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 13/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class EntrantNameTableViewCell: EntrantInformationTableViewCell {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    
    
    private(set) var entrantName: PersonName? = nil {
        
        didSet {
            if entrantName == nil {
                firstNameTextField.text = nil
                lastNameTextField.text = nil
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
    }
    
   
    override func resetData() {
        entrantName = nil
    }
    
    
    
    deinit {
        firstNameTextField = nil
        lastNameTextField = nil
        entrantName = nil
    }
    
}




extension EntrantNameTableViewCell: UITextFieldDelegate {
    
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if entrantName == nil {
            entrantName = PersonName(firstName:"", lastName: "")
        }
        
    }

    
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let newText = textField.text else {
            return
        }
        
        if textField == firstNameTextField {
            
            //First name
            entrantName?.updateFirstName(withString: newText)
        }
        else {
            
            //Last name
            entrantName?.updateLastName(withString: newText)

        }
        
    }
    
}
