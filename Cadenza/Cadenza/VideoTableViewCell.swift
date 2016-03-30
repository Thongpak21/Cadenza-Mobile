//
//  VideoTableViewCell.swift
//  Cadenza
//
//  Created by Thongpak on 3/30/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
