//
//  PassGenerationView.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 23/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

enum PassGenerationOption {
    case generatePass
    case populateData
}


class PassGenerationView: UIView {
    
    var passGenerationCompletionHandler: ((PassGenerationOption) -> Void)?
    
    
    
    init(withPassGenerationCompletionHandler handler: @escaping (PassGenerationOption)->Void) {
        passGenerationCompletionHandler = handler
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupPassGenerationButtons()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    deinit {
        passGenerationCompletionHandler = nil
    }
    
}



extension PassGenerationView {
    
    func setupPassGenerationButtons() {
        
        let generatePassButton: UIButton = UIButton(type: .roundedRect)
        generatePassButton.backgroundColor = UIColor(red: 62.0/255.0, green: 152.0/255.0, blue: 145.0/255.0, alpha: 1.0)
        generatePassButton.setTitle("Generate Pass", for: .normal)
        generatePassButton.addTarget(self, action: #selector(generatePassButtonTapped), for: .touchUpInside)
        generatePassButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        generatePassButton.setTitleColor(UIColor.white, for: .normal)
        
        let populateDataButton: UIButton = UIButton(type: .roundedRect)
        populateDataButton.backgroundColor = UIColor(red: 240.0/255.0, green: 235.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        populateDataButton.setTitle("Populate Data", for: .normal)
        populateDataButton.addTarget(self, action: #selector(populateEntrantDataButtonTapped), for: .touchUpInside)
        populateDataButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        populateDataButton.setTitleColor(UIColor(red: 62.0/255.0, green: 152.0/255.0, blue: 145.0/255.0, alpha: 1.0), for: .normal)


        let stackView: UIStackView = UIStackView(arrangedSubviews: [generatePassButton, populateDataButton])
        stackView.axis = .horizontal
        stackView.spacing = 32.0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32.0).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 32.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -84.0).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 70.0).isActive = true

        
    }
    
    
    @objc func generatePassButtonTapped() {
        passGenerationCompletionHandler?(.generatePass)
    }
    
    
    @objc func populateEntrantDataButtonTapped() {
        passGenerationCompletionHandler?(.populateData)
    }
    
}
