//
//  PostReplyTableViewCell.swift
//  Cadenza
//
//  Created by Thongpak on 4/28/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit

class PostReplyTableViewCell: UITableViewCell {
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var post: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // post.backgroundColor = UIColor.clearColor()
//        post.layer.cornerRadius = 5
//        post.layer.borderWidth = 1
//        post.layer.borderColor = UIColor.blackColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
