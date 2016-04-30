//
//  LessonDesTableViewCell.swift
//  Cadenza
//
//  Created by Thongpak on 4/30/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit

class LessonDesTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.numberOfLines = 0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
