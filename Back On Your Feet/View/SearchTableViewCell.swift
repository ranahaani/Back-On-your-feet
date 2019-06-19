//
//  SearchTableViewCell.swift
//  Back On Your Feet
//
//  Created by Talha khan on 30/04/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var diseaseLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        idLabel.layer.cornerRadius = idLabel.frame.width/2
        idLabel.layer.masksToBounds = true
        diseaseLabel.layer.masksToBounds = true
        titleLabel.layer.masksToBounds = true
        diseaseLabel.layer.cornerRadius = 2
        titleLabel.layer.cornerRadius = 2
        diseaseLabel.layer.borderWidth = 1
        idLabel.layer.borderWidth = 1
        titleLabel.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
