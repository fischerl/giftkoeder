//
//  LocationCell.swift
//  Giftkoeder
//
//  Created by Lisa Fischer on 19.06.15.
//  Copyright © 2015 TeamGK. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
