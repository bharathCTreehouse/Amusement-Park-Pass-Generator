//
//  EntrantCompanyInfoTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 22/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit


class EntrantCompanyInfoTableViewCell: EntrantInformationTableViewCell {
    
    @IBOutlet var companyTextField: UITextField!
    
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
