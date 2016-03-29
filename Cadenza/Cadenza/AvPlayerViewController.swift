//
//  AvPlayerViewController.swift
//  Cadenza
//
//  Created by Thongpak on 3/29/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class Av: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url:NSURL = NSURL(string:"https://www.youtube.com/watch?v=jYWehilunBo")!
        let player = AVPlayer(URL: url)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        self.addChildViewController(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.view.frame
        
        player.play()
    }
}
