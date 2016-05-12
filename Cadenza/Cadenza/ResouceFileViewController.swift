//
//  ResouceFileViewController.swift
//  Cadenza
//
//  Created by Thongpak on 5/10/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class ResouceFileViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.labelText = "Loading"
        super.viewDidLoad()
        webview.delegate = self
        Alamofire.request(.GET, mystruct.resourceFile!)
            .response { request, response, data, error in
                self.webview.loadRequest(request!)
        }
    }
    
    func webViewDidStartLoad(_: UIWebView){

    }
    func webViewDidFinishLoad(_: UIWebView){
        MBProgressHUD.hideAllHUDsForView(view, animated: true)
        //        print(WebCourseDes.scrollView.contentSize.height)
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
