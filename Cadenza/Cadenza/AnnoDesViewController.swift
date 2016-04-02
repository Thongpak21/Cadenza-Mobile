//
//  AnnoDesViewController.swift
//  Cadenza
//
//  Created by Thongpak on 4/3/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class AnnoDesViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var web: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webview()
        web.delegate = self
        // Do any additional setup after loading the view.
    }
    func webview() {
        Alamofire.request(.POST, "http://www.cadenza.in.th/v2/api/mobile/markdown", parameters:["markdown":mystruct.Annodes!])
            .response { request, response, data, error in
                self.web.loadRequest(request!)
        }
    }
    func webViewDidStartLoad(webView: UIWebView){
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.labelText = "Loading"
        UIApplication.sharedApplication().startNetworkActivity()
        
    }
    func webViewDidFinishLoad(webView: UIWebView){
        UIApplication.sharedApplication().stopNetworkActivity()
        MBProgressHUD.hideAllHUDsForView(view, animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
