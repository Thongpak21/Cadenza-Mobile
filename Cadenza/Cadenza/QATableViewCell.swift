//
//  QATableViewCell.swift
//  Cadenza
//
//  Created by Thongpak on 4/24/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit

class QATableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var numreply: UILabel!
    @IBOutlet weak var update: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        title.numberOfLines = 0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
