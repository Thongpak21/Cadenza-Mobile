//
//  ReplyTableViewCell.swift
//  Cadenza
//
//  Created by Thongpak on 4/27/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit

class ReplyTableViewCell: UITableViewCell {
    @IBOutlet weak var display: UIImageView!
    @IBOutlet weak var message: UILabel!

    @IBOutlet weak var postby: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
