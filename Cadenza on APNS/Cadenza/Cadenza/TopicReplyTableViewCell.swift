//
//  TopicReplyTableViewCell.swift
//  Cadenza
//
//  Created by Thongpak on 4/27/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit

class TopicReplyTableViewCell: UITableViewCell {

    @IBOutlet weak var titlename: UILabel!
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
