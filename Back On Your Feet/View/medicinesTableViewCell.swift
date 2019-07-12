//
//  medicinesTableViewCell.swift
//  Back On Your Feet
//
//  Created by Muhammad Abdullah on 12/07/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit

class medicinesTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UITextView!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
