//
//  EntrantNameTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 13/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class EntrantNameTableViewCell: UITableViewCell {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    private(set) var entrantName: PersonName? = PersonName(firstName:"", lastName: "") {
        
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
    
    
    
    func resetEntrantName() {
        entrantName = nil
    }
    
    
    
    func enableNameCell(_ enable: Bool) {
        
        UIView.animate(withDuration: 0.6) {
            
            if enable == true {
                self.contentView.alpha = 1.0
            }
            else {
                self.contentView.alpha = 0.1
            }
            self.contentView.isUserInteractionEnabled = enable
            self.resetEntrantName()
        }
        

    }
    
    
    
    deinit {
        firstNameTextField = nil
        lastNameTextField = nil
        entrantName = nil
    }
    
}



extension EntrantNameTableViewCell: UITextFieldDelegate {
    
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
