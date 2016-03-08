//
//  ShowCourseDetail.swift
//  Cadenza
//
//  Created by Thongpak on 1/27/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
class ShowCourseDetail: UIViewController,UIScrollViewDelegate,UIWebViewDelegate{
    @IBOutlet weak var imgheight: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
   // @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var height_layout: NSLayoutConstraint!
    @IBOutlet weak var WebCourseDes: UIWebView!
    @IBOutlet weak var viewbar: UIView!
    @IBOutlet weak var viaSegueLabel: UILabel!
    @IBOutlet weak var viewbar2: UIView!
    @IBOutlet weak var imgcov: UIImageView!
    var Name=""
    var myContext = 0
    var teacher:String?
    var coveimg:String?
    var des:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        webview()
        print(height_layout.constant)
        imgheight.constant = 150
        height_layout.constant = height_layout.constant - 270
        WebCourseDes.scrollView.scrollEnabled = false
        viaSegueLabel.text = Name
//        print(Name)
//        print(teacher)
//        print(coveimg)
//        print(des)
        Alamofire.request(.GET, coveimg!)
            .responseImage { response in
                if let image = response.result.value {
                    self.imgcov.image = image
                }
        }
 
        

        
        WebCourseDes.delegate = self
   //     self.WebCourseDes.addObserver(self, forKeyPath: "contentSize", options: .New, context: &myContext)

    }
      override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &myContext {
       //     height.constant = WebCourseDes.scrollView.contentSize.height
            //call layout update if needed
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    func webViewDidStartLoad(webView: UIWebView){
        
     //   activity.hidden = false
   //     activity.startAnimating()
        
    }
    func webViewDidFinishLoad(webView: UIWebView){
        
     //   activity.hidden = true
      //  activity.stopAnimating()
        height.constant = WebCourseDes.scrollView.contentSize.height

//        print(WebCourseDes.scrollView.contentSize.height)
    }


    func webview() {
        Alamofire.request(.POST, "http://www.cadenza.in.th/v2/api/mobile/markdown", parameters:["markdown":des!])
            .response { request, response, data, error in
                self.WebCourseDes.loadRequest(request!)
                       // print(self.WebCourseDes.scrollView.contentSize.height)
            UIApplication.sharedApplication().stopNetworkActivity()
        }
        
        UIApplication.sharedApplication().startNetworkActivity()
        
    }
    func layout() {
        viewbar.layer.cornerRadius = 1.0
        viewbar.layer.borderWidth = 1
        viewbar.layer.borderColor = UIColor.clearColor().CGColor
        viewbar.layer.masksToBounds = true
        
        viewbar.layer.shadowColor = UIColor.blackColor().CGColor
        viewbar.layer.shadowOffset = CGSizeMake(0, 1)
        viewbar.layer.shadowRadius = 1.0
        viewbar.layer.shadowOpacity = 1.0
        viewbar.layer.masksToBounds = false
        
        viewbar2.layer.cornerRadius = 1.0
        viewbar2.layer.borderWidth = 1
        viewbar2.layer.borderColor = UIColor.clearColor().CGColor
        viewbar2.layer.masksToBounds = true
        
        viewbar2.layer.shadowColor = UIColor.blackColor().CGColor
        viewbar2.layer.shadowOffset = CGSizeMake(0, 1)
        viewbar2.layer.shadowRadius = 1.0
        viewbar2.layer.shadowOpacity = 1.0
        viewbar2.layer.masksToBounds = false
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
