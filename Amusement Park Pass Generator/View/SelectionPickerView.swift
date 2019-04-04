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
    
    private var picker: UIPickerView = UIPickerView()
    private var listOfOptions: [String] = []
    private var completionHandler: ((Int) -> Void)? = nil
    
    
    required init(withPickerList list: [String],  completionHandler: @escaping ((Int) -> Void)) {
        
        listOfOptions = list
        self.completionHandler = completionHandler
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let toolBar: UIToolbar = UIToolbar(frame:.zero)
        toolBar.barStyle = .blackOpaque
        addSubview(toolBar)
        toolBar.configure(withConstraints: [.leading(referenceConstraint: leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .trailing(referenceConstraint: trailingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .top(referenceConstraint: topAnchor, constantOffSet: 0.0, equalityType: .equalTo), .height(constantOffSet: 60.0, equalityType: .equalTo)])
        let space: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped(_:)))
        toolBar.setItems([space,doneButton], animated: false)
        
        
        addSubview(picker)
        picker.configure(withConstraints: [.leading(referenceConstraint: leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .trailing(referenceConstraint: trailingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .top(referenceConstraint: toolBar.bottomAnchor, constantOffSet: 8.0, equalityType: .equalTo), .bottom(referenceConstraint: bottomAnchor, constantOffSet: 0.0, equalityType: .equalTo)])
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = UIColor.clear
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @objc private func doneButtonTapped(_ sender: UIBarButtonItem) {
        completionHandler?(picker.selectedRow(inComponent: 0))
    }
    
    
    func closeSelectionPickerView() {
        completionHandler?(picker.selectedRow(inComponent: 0))
    }
    
    
    deinit {
        completionHandler = nil
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
            return nil
        }
        
    }
    
}
