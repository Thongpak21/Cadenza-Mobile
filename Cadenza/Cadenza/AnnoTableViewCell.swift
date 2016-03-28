//
//  AnnoTableViewCell.swift
//  Cadenza
//
//  Created by Thongpak on 3/27/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
class AnnoTableViewCell: UITableViewCell,UIScrollViewDelegate,UIWebViewDelegate {
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var height_web: NSLayoutConstraint!
    @IBOutlet weak var Title: UILabel!
    class var expandedHeight: CGFloat { get { return 300 } }
    class var defaultHeight: CGFloat { get { return 188 } }
    func checkheight() {
        web.hidden = (frame.size.height < AnnoTableViewCell.expandedHeight)
    }
    func loadwebview(text:String){
        web.delegate = self
        Alamofire.request(.POST, "http://www.cadenza.in.th/v2/api/mobile/markdown", parameters:["markdown":text])
            .response { request, response, data, error in
                self.web.loadRequest(request!)
        }
       // print(web.scrollView.contentSize.height)
    }
    func webViewDidStartLoad(webview: UIWebView){
        UIApplication.sharedApplication().startNetworkActivity()
        
        
    }
    func webViewDidFinishLoad(webview: UIWebView){
        UIApplication.sharedApplication().stopNetworkActivity()
   //     print(web.scrollView.contentSize.height)
    //    height_web.constant = web.scrollView.contentSize.height
    }


}
