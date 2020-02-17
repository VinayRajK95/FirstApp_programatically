//
//  AppTableViewCell.swift
//  ASA_assignment
//
//  Created by Infosys on 1/16/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class AppTableViewCell: UITableViewCell {

    @IBOutlet var appImage: UIImageView!
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var descr: UILabel!
    
    @IBOutlet var getOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(apps : AppModel){
        let url = URL(string: apps.artworkUrl60)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let image = data else {
                return
            }
            let icon = UIImage(data: image)
            DispatchQueue.main.async {
                self.appImage.image = icon
            }
        }
        task.resume()
        self.descr.text = apps.description
        self.title.text = apps.trackCensoredName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
