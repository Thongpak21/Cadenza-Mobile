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
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var imgheight: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var height_layout: NSLayoutConstraint!
    @IBOutlet weak var WebCourseDes: UIWebView!
    @IBOutlet weak var viewbar: UIView!
    @IBOutlet weak var viaSegueLabel: UILabel!
    @IBOutlet weak var viewbar2: UIView!
    @IBOutlet weak var viewbar3: UIView!
    @IBOutlet weak var imgcov: UIImageView!
    
   private var section_model = [model]()
    var Name=""
    var myContext = 0
    var teacher:String?
    var coveimg:String?
    var des:String?
    var courseID:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
//        tableview.scrollEnabled = false
//        print(tableview.scrollEnabled.hashValue)
        webview()
//        print(height_layout.constant)
//        print(courseID!)

        imgheight.constant = 150
        height_layout.constant = height_layout.constant
        WebCourseDes.scrollView.scrollEnabled = false
        viaSegueLabel.text = Name
        Alamofire.request(.GET, coveimg!)
            .responseImage { response in
                if let image = response.result.value {
                    self.imgcov.image = image
                }
        }
 
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundView = nil
    //    view.addSubview(tableview!)
    //    tableview.reloadData()
        
        WebCourseDes.delegate = self
    }
    func getSection() {
        Alamofire.request(.GET, "http://cadenza.in.th/api/mobile/course/show/\(courseID!)")
            .responseJSON{ response in
            //    print(response.result.value![0])
                if let results = response.result.value!["section"] as? [[String: AnyObject]] {
                    dispatch_async(dispatch_get_main_queue(),{
                        self.tableview.reloadData()
                    })
                    for i in results {
                  //      print("\(model(i).sectionName)   --->  \(model(i).courseID)")
                        self.section_model.append(model(i))
                    }
              //      print(self.section_model.count)

                }
            }
    }
   
    func webViewDidStartLoad(webview: UIWebView){
        activity.hidden = false
        UIApplication.sharedApplication().startNetworkActivity()
        activity.startAnimating()
        
    }
    func webViewDidFinishLoad(webview: UIWebView){
        UIApplication.sharedApplication().stopNetworkActivity()
        activity.hidden = true
        activity.stopAnimating()
        height.constant = WebCourseDes.scrollView.contentSize.height
        getSection()
    }


    func webview() {
        Alamofire.request(.POST, "http://www.cadenza.in.th/v2/api/mobile/markdown", parameters:["markdown":des!])
            .response { request, response, data, error in
                self.WebCourseDes.loadRequest(request!)
        }
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
        
        viewbar3.layer.cornerRadius = 1.0
        viewbar3.layer.borderWidth = 1
        viewbar3.layer.borderColor = UIColor.clearColor().CGColor
        viewbar3.layer.masksToBounds = true
        
        viewbar3.layer.shadowColor = UIColor.blackColor().CGColor
        viewbar3.layer.shadowOffset = CGSizeMake(0, 1)
        viewbar3.layer.shadowRadius = 1.0
        viewbar3.layer.shadowOpacity = 1.0
        viewbar3.layer.masksToBounds = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  

}
extension ShowCourseDetail : UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section_model.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let data_cell = section_model[indexPath.row]
        cell.textLabel?.text = data_cell.sectionName
        cell.detailTextLabel?.text = "Enroll"
       // print(data_cell.sectionID)
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let data_cell = section_model[indexPath.row]
        var tLabel: UILabel!
        var tField: UITextField!
        func configTextField(textField: UITextField!){
            textField.placeholder = data_cell.sectionName
            tField = textField
        }
        func LabelText(Label:UILabel!){
            tLabel.text = data_cell.sectionName
        }
        
        
 //       let mes = [data_cell.sectionName!,data_cell.sectionToken!]
        print(data_cell.sectionID)
        print(data_cell.sectionName)
        print(data_cell.sectionToken)
        let alert = UIAlertController(title: viaSegueLabel.text, message:"Sec : \(data_cell.sectionName!)",preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
//        alert.addTextFieldWithConfigurationHandler(configTextField)
        self.presentViewController(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Enroll", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                print("hello")
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
            }
        }))
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension ShowCourseDetail: UITableViewDelegate {
    
}