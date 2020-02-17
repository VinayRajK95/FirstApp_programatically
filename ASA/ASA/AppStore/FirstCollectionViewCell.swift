//
//  FirstCollectionViewCell.swift
//  ASA_assignment
//
//  Created by Infosys on 1/16/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var appImage: UIImageView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/8
        
    }
    
    override func prepareForReuse() {
        appImage.image = nil
    }
    
    func downloadImage(urlOfImage: URL){
        let task = URLSession.shared.dataTask(with: urlOfImage) { (data, response, error) in
            guard let image = data else {
                return
            }
            let icon = UIImage(data: image)
            DispatchQueue.main.async {
                self.appImage.image = icon
            }
            
        }
        task.resume()
    }
}
