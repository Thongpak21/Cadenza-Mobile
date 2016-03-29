//
//  SegmentViewController.swift
//  Cadenza
//
//  Created by Thongpak on 3/22/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import CarbonKit
import Alamofire
class SegmentViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tabBarController?.tabBar.hidden = true
        let items = ["Lecture","Announcement","Video","Student","Assignment"]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.insertIntoRootViewController(self)
//        print(mystruct.courseID)
//        print(mystruct.json_instruct![0,"SectionID"])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAtIndex index: UInt) -> UIViewController {
        switch (index) {
        case 0:
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Lecture")
           return  viewController
            
        case 1:
            return UIStoryboard(name: "Main",bundle: nil).instantiateViewControllerWithIdentifier("Anno")
            
        case 2:
            return UIStoryboard(name: "Main",bundle: nil).instantiateViewControllerWithIdentifier("video")
        default:
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
            return  viewController
        }
    }
}
