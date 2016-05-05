//
//  LessonDes.swift
//  Cadenza
//
//  Created by Thongpak on 4/2/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class LessonDes: UIViewController,UIScrollViewDelegate {

    @IBOutlet var tableview: UITableView!
   // @IBOutlet weak var web: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundView = nil
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight = 10
        self.tableview.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)

   //     webview()
   //     web.delegate = self
        // Do any additional setup after loading the view.
    }
//    func webview() {
//        Alamofire.request(.POST, "http://www.cadenza.in.th/v2/api/mobile/markdown", parameters:["markdown":mystruct.Lessondes!])
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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension LessonDes:UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("lesson", forIndexPath: indexPath)
        let str = mystruct.Lessondes!.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        
//        let regex = try! NSRegularExpression(pattern: "<.*?>", options: [.CaseInsensitive])
//        
//        let range = NSMakeRange(0, mystruct.Lessondes!.characters.count)
//        let htmlLessString :String = regex.stringByReplacingMatchesInString(mystruct.Lessondes!, options: [],
//                                                                            range:range ,
//                                                                            withTemplate: "")
        
//        print(str)
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

extension LessonDes:UITableViewDelegate{
    
    
}
