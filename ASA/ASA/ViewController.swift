//
//  ViewController.swift
//  ASA
//
//  Created by Infosys on 1/16/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    
    let cells = ["Card Details" : [["type":"LabelNumber","title":"Card Number","value":"1234 5451 5624 2451","placeholder":"4215 4512 5484 2521"],["type":"LabelNumber","title":"CVV","value":"","placeholder":"458"],["type":"Picker","title":"Expiry","value":"","placeholder":"Mon/yyyy"],["type":"LabelString","title":"Name","value":"","placeholder":"Smith"]], "Address": [["type":"LabelString","title":"First Name","value":"","placeholder":"Johny"],["type":"LabelString","title":"Last Name","value":"","placeholder":"Bravo"],["type":"LabelPhoneNumber","title":"Phone Number","value1":"+91","value2":"8792362045","placeholder1":"+91","placeholder2":"99051436245"]]]
    
    var keys : Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        setupTableViewConstraints()
        registerTableViewCells()
        
        keys = Array(cells.keys)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupTableViewConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
    
    func registerTableViewCells(){
        tableView.register(LabelNumberTableViewCell.self, forCellReuseIdentifier: "LabelNumber")
        tableView.register(LabelStringTableViewCell.self, forCellReuseIdentifier: "LabelString")
        tableView.register(PickerTableViewCell.self, forCellReuseIdentifier: "Picker")
        tableView.register(LabelPhoneNumberTableViewCell.self, forCellReuseIdentifier: "LabelPhoneNumber")
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys![section]
        guard let count = cells[key]?.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = keys![indexPath.section]
        let type = cells[key]![indexPath.row]["type"]
        if let cell = tableView.dequeueReusableCell(withIdentifier: type!) as? ConfigureCellProtocol{
            cell.configureCell(data: cells[key]![indexPath.row])
            return cell as! UITableViewCell
        }
        return UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys?[section]
    }
}

protocol ConfigureCellProtocol {
    func configureCell(data: [String:String])
}

