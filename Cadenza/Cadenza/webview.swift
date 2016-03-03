//
//  webview.swift
//  Cadenza
//
//  Created by Thongpak on 2/3/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire

class webview: UIViewController,UIWebViewDelegate {
    let data = [
        "markdown":"**1. Front End** หมายถึง ระบบในส่วนของหน้าเว็บไซต์การออกแบบ การแสดงผล เพื่อให้เกิดความสวยงาม โดยเราจะใช้ HTML, CSS, JavaScript เป็นภาษาหลัก"
    ]
    var myContext = 0
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var height: NSLayoutConstraint!
    var contentHeights : [CGFloat] = [0.0, 0.0]
    @IBOutlet weak var web: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "http://www.cadenza.in.th")
            .response { request, response, data, error in
        self.web.loadRequest(request!)
        }
        web.scrollView.scrollEnabled = false
        web.scrollView.addObserver(self, forKeyPath: "contentSize", options: .New, context: &myContext)
        web.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    func webViewDidFinishLoad(webView: UIWebView){

        height.constant = web.scrollView.contentSize.height
        print(web.scrollView.contentSize.height)
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &myContext {
            height.constant = web.scrollView.contentSize.height
            //call layout update if needed
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
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
