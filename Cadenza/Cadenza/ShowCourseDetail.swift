//
//  ShowCourseDetail.swift
//  Cadenza
//
//  Created by Thongpak on 1/27/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit

class ShowCourseDetail: UIViewController {

    @IBOutlet weak var viaSegueLabel: UILabel!
    var viaSegue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        viaSegueLabel.text = viaSegue
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
