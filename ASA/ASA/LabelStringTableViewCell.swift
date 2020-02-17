//
//  LabelStringTableViewCell.swift
//  ASA
//
//  Created by Infosys on 1/17/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class LabelStringTableViewCell: UITableViewCell, ConfigureCellProtocol {

    
    let labelString : UILabel = {
        let innerLabel = UILabel()
        innerLabel.textColor = UIColor.black
        innerLabel.textAlignment = .left
        return innerLabel
    }()
    
    let textFieldString : UITextField = {
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
        self.addSubview(labelString)
        self.addSubview(textFieldString)
        textFieldString.delegate = self
        labelString.translatesAutoresizingMaskIntoConstraints = false
        textFieldString.translatesAutoresizingMaskIntoConstraints = false
        textFieldString.setContentHuggingPriority(.defaultLow, for: .horizontal)
        labelString.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textFieldString.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        labelString.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        labelString.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        labelString.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        textFieldString.leadingAnchor.constraint(equalTo: labelString.trailingAnchor, constant : 8).isActive = true
        textFieldString.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        textFieldString.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        textFieldString.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }

    func configureCell(data: [String:String]){
        let title = data["title"]
        let value = data["value"]
        let placeholder = data["placeholder"]
        self.labelString.text = title
        self.textFieldString.text = value
        self.textFieldString.placeholder = placeholder
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension LabelStringTableViewCell: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let alphabets = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        return alphabets.isSuperset(of: characterSet)
    }
}
