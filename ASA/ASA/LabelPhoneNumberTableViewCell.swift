//
//  LabelPhoneNumberTableViewCell.swift
//  ASA
//
//  Created by Infosys on 1/17/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class LabelPhoneNumberTableViewCell: UITableViewCell, ConfigureCellProtocol {

    let labelPhone : UILabel = {
        let innerLabel = UILabel()
        innerLabel.textColor = UIColor.black
        innerLabel.textAlignment = .left
        return innerLabel
    }()
    
    let textFieldCountryCode : UITextField = {
        let innerTextField = UITextField()
        innerTextField.font = UIFont.systemFont(ofSize: 15)
        innerTextField.borderStyle = UITextBorderStyle.roundedRect
        return innerTextField
    }()
    
    let textFieldPhoneNumber : UITextField = {
        let innerTextField = UITextField()
        innerTextField.font = UIFont.systemFont(ofSize: 15)
        innerTextField.borderStyle = UITextBorderStyle.roundedRect
        return innerTextField
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        self.addSubview(labelPhone)
        self.addSubview(textFieldCountryCode)
        self.addSubview(textFieldPhoneNumber)
        textFieldPhoneNumber.delegate = self
        textFieldCountryCode.delegate = self
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
        textFieldCountryCode.translatesAutoresizingMaskIntoConstraints = false
        textFieldPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        labelPhone.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textFieldCountryCode.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textFieldPhoneNumber.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        labelPhone.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        labelPhone.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        labelPhone.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        textFieldCountryCode.leadingAnchor.constraint(equalTo: labelPhone.trailingAnchor, constant : 8).isActive = true
        
        textFieldCountryCode.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        textFieldCountryCode.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        textFieldPhoneNumber.leadingAnchor.constraint(equalTo: textFieldCountryCode.trailingAnchor, constant : 8).isActive = true
        textFieldPhoneNumber.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        textFieldPhoneNumber.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        textFieldPhoneNumber.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    }
    
    func configureCell(data: [String:String]){
        let title = data["title"]
        let value1 = data["value1"]
        let value2 = data["value2"]
        let placeholder1 = data["placeholder1"]
        let placeholder2 = data["placeholder2"]
        self.labelPhone.text = title
        self.textFieldCountryCode.text = value1
        self.textFieldPhoneNumber.text = value2
        self.textFieldCountryCode.placeholder = placeholder1
        self.textFieldPhoneNumber.placeholder = placeholder2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension LabelPhoneNumberTableViewCell: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
            let numbers = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return numbers.isSuperset(of: characterSet)
    }
}
