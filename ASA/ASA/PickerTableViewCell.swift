//
//  PickerTableViewCell.swift
//  ASA
//
//  Created by Infosys on 1/17/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell, ConfigureCellProtocol {

    let labelPicker : UILabel = {
        let innerLabel = UILabel()
        innerLabel.textColor = UIColor.black
        innerLabel.textAlignment = .left
        return innerLabel
    }()
    
    let textFieldPicker : UITextField = {
        let innerTextField = UITextField()
        innerTextField.placeholder = "Mon/yyyy "
        innerTextField.font = UIFont.systemFont(ofSize: 15)
        innerTextField.borderStyle = UITextBorderStyle.roundedRect
        return innerTextField
    }()
    
    var monthsAndYear = [["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],["2017","2018","2019","2020","2021","2022","2023"]]
    
    var pickerView : UIPickerView?
    
    var expiry = NSMutableString()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupPickerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        self.addSubview(labelPicker)
        self.addSubview(textFieldPicker)
        textFieldPicker.delegate = self
        labelPicker.translatesAutoresizingMaskIntoConstraints = false
        textFieldPicker.translatesAutoresizingMaskIntoConstraints = false
        
        labelPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        labelPicker.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        labelPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        textFieldPicker.leadingAnchor.constraint(equalTo: labelPicker.trailingAnchor, constant : 8).isActive = true
        
        textFieldPicker.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -16).isActive = true
        textFieldPicker.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        textFieldPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }

    func setupPickerView(){
        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self
        expiry = "Jan/2017"
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(PickerTableViewCell.donePicker))
        
        toolBar.setItems([ doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.textFieldPicker.inputView = pickerView
        self.textFieldPicker.inputAccessoryView = toolBar
    }
    
    func configureCell(data: [String:String]){
        let title = data["title"]
        let value = data["value"]
        let placeholder = data["placeholder"]
        self.labelPicker.text = title
        self.textFieldPicker.text = value
        self.textFieldPicker.placeholder = placeholder
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func donePicker(){
        if (self.textFieldPicker.text?.isEmpty)!{
            pickerView(pickerView!, didSelectRow: 0, inComponent: 0)
            pickerView(pickerView!, didSelectRow: 0, inComponent: 1)
        }
        self.textFieldPicker.resignFirstResponder()
    }
    
}

extension PickerTableViewCell:  UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return monthsAndYear.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return monthsAndYear[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return monthsAndYear[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            expiry.replaceCharacters(in: NSRange(location: 0, length: 3), with: monthsAndYear[0][row])
        }
        else{
            expiry.replaceCharacters(in: NSRange(location: 4, length: 4), with: monthsAndYear[1][row])
        }
        self.textFieldPicker.text = expiry as String
    }
}

extension PickerTableViewCell: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return false
    }
}
