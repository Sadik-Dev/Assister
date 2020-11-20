//
//  ContatcTableViewCell.swift
//  Assister
//
//  Created by Sana on 11/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellIcon: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var numberOfConsultations: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var editButton: UIImageView!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
