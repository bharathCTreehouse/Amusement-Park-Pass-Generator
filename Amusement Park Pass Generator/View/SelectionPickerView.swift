//
//  SelectionPickerView.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 11/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class SelectionPickerView: UIView {
    
    var picker: UIPickerView? = nil
    var listOfOptions: [String] = []
    
    
    required init(withPickerList list: [String]) {
        
        listOfOptions = list
        picker = UIPickerView()
        picker!.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(picker!)
        picker!.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        picker!.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        picker!.topAnchor.constraint(equalTo: topAnchor).isActive = true
        picker!.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        picker!.dataSource = self
        picker!.delegate = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    deinit {
        picker = nil
    }
    
}

extension SelectionPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfOptions.count
    }
}


extension SelectionPickerView: UIPickerViewDelegate {
    
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 60.0
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if listOfOptions.count > row {
            return listOfOptions[row]
        }
        else {
            return ""
        }
        
    }
    
}
