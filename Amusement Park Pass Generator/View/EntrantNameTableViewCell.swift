//
//  EntrantNameTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 13/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class EntrantNameTableViewCell: EntrantInformationTableViewCell {
    
    @IBOutlet private(set) var firstNameTextField: UITextField!
    @IBOutlet private(set) var lastNameTextField: UITextField!
    
    private(set) var entrantNameDataSource: EntrantNameDataSource? = nil {
        
        didSet {
            
            firstNameTextField.text = entrantNameDataSource?.entrantName?.firstName
            lastNameTextField.text = entrantNameDataSource?.entrantName?.lastName
            
        }
    }
    
    
    
    func updateDataSource(with dataSource: EntrantNameDataSource) {
        entrantNameDataSource = dataSource
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
    }
    
   
   
    deinit {
        firstNameTextField = nil
        lastNameTextField = nil
        entrantNameDataSource = nil
    }
    
}




extension EntrantNameTableViewCell {
    
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let newText = textField.text else {
            return
        }
        
        if textField == firstNameTextField {
            
            //First name
            entrantNameDataSource?.updateFirstName(with: newText)
        }
        else {
            
            //Last name
            entrantNameDataSource?.updateLastName(with: newText)
            
        }
        
    }
    
}
