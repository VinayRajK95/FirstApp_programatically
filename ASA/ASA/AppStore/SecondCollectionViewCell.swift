//
//  SecondCollectionViewCell.swift
//  ASA_assignment
//
//  Created by Infosys on 1/16/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    @IBOutlet var tableView: UITableView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/8
    }

}
