//
//  NewTableViewCell.swift
//  CheckList
//
//  Created by MacBook Pro on 15.03.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {

     var button: UIButton!
    
    @IBOutlet weak var labelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
