//
//  LabelNumberTableViewCell.swift
//  ASA
//
//  Created by Infosys on 1/16/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class LabelNumberTableViewCell: UITableViewCell, ConfigureCellProtocol {

    let labelNumber : UILabel = {
        let innerLabel = UILabel()
        innerLabel.textColor = UIColor.black
        innerLabel.textAlignment = .left
        return innerLabel
    }()
    
    let textFieldNumber : UITextField = {
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
        self.addSubview(labelNumber)
        self.addSubview(textFieldNumber)
        textFieldNumber.delegate = self
        
        labelNumber.translatesAutoresizingMaskIntoConstraints = false
        textFieldNumber.translatesAutoresizingMaskIntoConstraints = false
        textFieldNumber.setContentHuggingPriority(.defaultLow, for: .horizontal)
        labelNumber.setContentHuggingPriority(.defaultHigh, for: .horizontal)
              
        
        labelNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        labelNumber.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        labelNumber.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        textFieldNumber.leadingAnchor.constraint(equalTo: labelNumber.trailingAnchor, constant : 8).isActive = true
        textFieldNumber.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        textFieldNumber.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        textFieldNumber.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
    }
    
    func configureCell(data: [String:String]){
        let title = data["title"]
        let value = data["value"]
        let placeholder = data["placeholder"]
        self.labelNumber.text = title
        self.textFieldNumber.text = value
        self.textFieldNumber.placeholder = placeholder
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension LabelNumberTableViewCell: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let numbers = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return numbers.isSuperset(of: characterSet)
    }
}
