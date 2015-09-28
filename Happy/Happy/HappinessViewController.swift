//
//  HappinessViewController.swift
//  Happy
//
//  Created by Thongpak on 9/27/2558 BE.
//  Copyright © 2558 Thongpak. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController,FaceViewDataSource {
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
//            faceView.addGestur eRecognizer(UIPanGestureRecognizer(target: self, action: "changeHappiness:"))
        }
    }
    var happiness:Int  = 75 { // 0 = very sad. 100 = ecstatic
        didSet {
            happiness = min(max(happiness,0),100)
            print("happiness = \(happiness)")
            updateUI()
        }
    }
    private func updateUI (){
        faceView.setNeedsDisplay()
        
    }
    func smilinessForFaceView(sender:FaceView) -> Double? {
        return Double(happiness-50)/50
    }
}
