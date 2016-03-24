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
        let items = ["Lecture","Video","Student","Announcement","Assignment"]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.insertIntoRootViewController(self)
        print(mystruct.courseID)
        print(mystruct.json_instruct![0,"SectionID"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAtIndex index: UInt) -> UIViewController {
        // return viewController at index
        switch (index) {
        case 0:
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Lecture")
           return  viewController
            //   return [self.storyboard instantiateViewControllerWithIdentifier:"ViewControllerOne"]
            
//        case 1:
//            return [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerTwo"];
//            
        default:
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
            return  viewController
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
