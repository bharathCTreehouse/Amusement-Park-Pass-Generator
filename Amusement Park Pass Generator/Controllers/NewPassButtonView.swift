//
//  NewPassButtonView.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 21/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class NewPassButtonView: UIView {
    
    var buttonTitle: String = ""
    var buttonTapHandler: (() -> Void)? = nil
    var button: UIButton? = nil
    
    
    init(withButtonTitle title: String, buttonActionHandler: @escaping (() -> Void)) {
        
        buttonTapHandler = buttonActionHandler
        buttonTitle = title
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupButton() {
        
        if button == nil {
            
            button = UIButton(type: .system)
            addSubview(button!)
            button!.setTitle(buttonTitle, for: .normal)
            button!.setTitleColor(UIColor.white, for: .normal)
            button!.translatesAutoresizingMaskIntoConstraints = false
            button!.backgroundColor = UIColor(red: 62.0/255.0, green: 152.0/255.0, blue: 145.0/255.0, alpha: 1.0)
            button!.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)

            
            button!.configure(withConstraints: [.leading(referenceConstraint: leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .trailing(referenceConstraint: trailingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .top(referenceConstraint: topAnchor, constantOffSet: 0.0, equalityType: .equalTo), .bottom(referenceConstraint: bottomAnchor, constantOffSet: 0.0, equalityType: .equalTo)])
            
            button!.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
    }
    
    
    
    @objc func buttonTapped(_ sender: UIButton) {
        
        buttonTapHandler?()
    }
    
    
    deinit {
        buttonTapHandler = nil
        button = nil
    }
}
