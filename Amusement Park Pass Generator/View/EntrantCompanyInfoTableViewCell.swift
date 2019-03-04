//
//  EntrantCompanyInfoTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 22/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit


class EntrantCompanyInfoTableViewCell: UITableViewCell {
    
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
    
    
    
    func resetEntrantCompanyName() {
        entrantCompanyName = nil
    }
    
    
    func enableCompanyCell(_ enable: Bool) {
        
        UIView.animate(withDuration: 0.6) {
            
            if enable == true {
                self.contentView.alpha = 1.0
            }
            else {
                self.contentView.alpha = 0.1
            }
            self.contentView.isUserInteractionEnabled = enable
            self.resetEntrantCompanyName()
        }
        
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
