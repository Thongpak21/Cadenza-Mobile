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
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  webview()
      //  web.delegate = self
        // Do any additional setup after loading the view.
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundView = nil
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight = 10
    }
//    func webview() {
//        Alamofire.request(.POST, "http://www.cadenza.in.th/v2/api/mobile/markdown", parameters:["markdown":mystruct.Annodes!])
//            .response { request, response, data, error in
//                self.web.loadRequest(request!)
//        }
//    }
//    func webViewDidStartLoad(webView: UIWebView){
//        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
//        hud.labelText = "Loading"
//        UIApplication.sharedApplication().startNetworkActivity()
//        
//    }
//    func webViewDidFinishLoad(webView: UIWebView){
//        UIApplication.sharedApplication().stopNetworkActivity()
//        MBProgressHUD.hideAllHUDsForView(view, animated: true)
//    }
//    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension AnnoDesViewController:UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("lesson", forIndexPath: indexPath)
        let str = mystruct.Annodes!.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        cell.textLabel!.text = str
        //   self.tableview.rowHeight = UITableViewAutomaticDimension
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //
    //    }
}

extension AnnoDesViewController:UITableViewDelegate{
    
    
}
