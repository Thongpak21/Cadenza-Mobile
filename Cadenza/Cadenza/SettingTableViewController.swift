//
//  SettingTableViewController.swift
//  Cadenza
//
//  Created by Thongpak on 5/6/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    @IBOutlet weak var lname: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var displayimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        displayimage.layer.borderWidth = 1
        displayimage.layer.masksToBounds = false
        displayimage.layer.borderColor = UIColor.blackColor().CGColor
        displayimage.layer.cornerRadius = displayimage.frame.height/2
        displayimage.clipsToBounds = true
        
        
        if let _ = mystruct.pro_display {
            let string = "http://cadenza.in.th"+"\(mystruct.pro_display!)"
            let url:NSURL? = NSURL(string:string)
            displayimage.sd_setImageWithURL(url)
            
            name.text = "\(mystruct.pro_fname!)"
            lname.text = mystruct.pro_lname!
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.section)
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                Token().removetoken()
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                                        self.presentViewController(viewController, animated: true, completion: nil)
                                    })

            }
        }
    }
   
}
