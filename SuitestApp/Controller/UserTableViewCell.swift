//
//  UserTableViewCell.swift
//  SuitestApp
//
//  Created by Farhan Mazario on 29/04/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var emailUser: UILabel!
    @IBOutlet weak var imagesUser: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
