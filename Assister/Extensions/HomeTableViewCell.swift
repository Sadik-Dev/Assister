//
//  HomeTableViewCell.swift
//  Assister
//
//  Created by Sana on 24/10/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

  
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellIcon: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
