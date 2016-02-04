//
//  webview.swift
//  Cadenza
//
//  Created by Thongpak on 2/3/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire

class webview: UIViewController {
    let data = [
        "markdown":"**1. Front End** หมายถึง ระบบในส่วนของหน้าเว็บไซต์การออกแบบ การแสดงผล เพื่อให้เกิดความสวยงาม โดยเราจะใช้ HTML, CSS, JavaScript เป็นภาษาหลัก"
    ]
    @IBOutlet weak var web: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "http://www.google.co.th")
            .response { request, response, data, error in
        self.web.loadRequest(request!)
        }
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
