//
//  ReadyTextTableViewCell.swift
//  CheckList
//
//  Created by MacBook Pro on 06.02.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit

class ReadyTextTableViewCell: UITableViewCell {

    @IBOutlet weak var cellText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
