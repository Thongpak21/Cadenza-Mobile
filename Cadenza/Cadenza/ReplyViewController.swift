//
//  ReplyViewController.swift
//  Cadenza
//
//  Created by Thongpak on 4/25/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import IQKeyboardManagerSwift
import SwiftyJSON
class ReplyViewController: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var data_model = [model]()
    var titlename:String?
    var postby:String?
    var topicdes:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        message.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ReplyViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        postby = mystruct.topic_postby!
        titlename = mystruct.topictitle!
        
        
        IQKeyboardManager.sharedManager().disabledToolbarClasses.insert(NSStringFromClass(ReplyViewController))
        self.tableview.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)
        
        
        if mystruct.secID == nil {
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.json_instruct![0,"SectionID"])/topics/\(mystruct.topicID!)?access_token=\(Token().getToken())")
            
        }else{
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.secID!)/topics/\(mystruct.topicID!)?access_token=\(Token().getToken())")
        }
        //   self.automaticallyAdjustsScrollViewInsets = false
        
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight = 8
        tableview.delegate = self
    }
    override func viewWillDisappear(animated : Bool) {
        super.viewWillDisappear(animated)
        
       // IQKeyboardManager.sharedManager().shouldToolbarUsesTextFieldTintColor = false
        
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func post(sender: AnyObject) {
        if message.text == "" {
            
        }else{
         //   print(message.text)
            if mystruct.secID == nil {
                alamo_reply("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.json_instruct![0,"SectionID"])/topics/\(mystruct.topicID!)",data: message.text!)
                
            }else{
                alamo_reply("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.secID!)/topics/\(mystruct.topicID!)",data: message.text!)
            }
      //      print(mystruct.pro_display_thumbnail)
//            let a = ["TopicReplyDescription":message.text!, "TopicID": 5, "UserID": 2, "lastname": mystruct.pro_lname!, "display_thumbnail": mystruct.pro_display_thumbnail!, "firstname": mystruct.pro_fname!]
//           // print(a)
//            data_model.append(model(a as! [String : AnyObject]))
//            message.text = ""
//            tableview.beginUpdates()
//            tableview.insertRowsAtIndexPaths([NSIndexPath(forRow: data_model.count, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Bottom)
//            tableview.endUpdates()
        }
    }
    func alamo_Lecture(url:String){
        // print(url)
        Alamofire.request(.GET,url)
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
            //    print(response.result.value!)
                self.topicdes = response.result.value!["TopicDescription"] as? String
                if let results = response.result.value!["topicreply"] as? [[String: AnyObject]] {
                    for i in results {
                   //       print(i)
                        //    print("\(model(i))   --->  \(model(i).topicID)")
                        self.data_model.append(model(i))
                    }
                }
                
                UIApplication.sharedApplication().stopNetworkActivity()
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableview.reloadData()

                    self.tableview.dataSource = self
                })
        }
        
        
    }
    func alamo_delete(url:String){
        // print(url)
        let data = ["access_token":Token().getToken(),"_method":"delete"]
        Alamofire.request(.POST,url,parameters:data)
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
                UIApplication.sharedApplication().stopNetworkActivity()
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableview.reloadData()
                    
                    self.tableview.dataSource = self
                })
        }
        
    }
    func alamo_reply(url:String,data:String){
        // print(url)
        let reply = ["access_token":Token().getToken(),
                     "TopicReplyDescription":data]
        Alamofire.request(.POST,url,parameters:reply)
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
                let json = JSON(response.result.value!)
             //   print(json["TopicReplyID"])
                let a = ["TopicReplyID":"\(json["TopicReplyID"].int)","TopicReplyDescription":self.message.text!, "TopicID": 5, "UserID": 2, "lastname": mystruct.pro_lname!, "display_thumbnail": mystruct.pro_display_thumbnail!, "firstname": mystruct.pro_fname!]
           //      print(a)
                self.data_model.append(model(a as! [String : AnyObject]))
                self.data_model[self.data_model.count-1].topicReplyID = json["TopicReplyID"].int
            //    print(self.data_model[self.data_model.count-1].topicReplyID)
                self.message.text = ""
                self.tableview.beginUpdates()
                self.tableview.insertRowsAtIndexPaths([NSIndexPath(forRow: self.data_model.count, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Bottom)
                self.tableview.endUpdates()
               // print(response.result.value!["TopidID"])
        //        self.data_model[self.data_model.count].topicReplyID = response.result.value!["TopicReplyID"]
                UIApplication.sharedApplication().stopNetworkActivity()
                dispatch_async(dispatch_get_main_queue(),{
                   // self.tableview.reloadData()
                    self.tableview.dataSource = self
                })
        }
      //  message.text = ""
        
    }

   
}
extension ReplyViewController : UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  //      print(data_model.count)
        return data_model.count+3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         // print("indexpath \(indexPath.row)")
        if indexPath.row == 0 {
            return topic(indexPath)
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("blank", forIndexPath: indexPath)
            
            cell.textLabel?.text = ""
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("message", forIndexPath: indexPath)
            cell.textLabel?.text = topicdes
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("reply", forIndexPath: indexPath) as! ReplyTableViewCell
            let string = "http://cadenza.in.th/\(data_model[indexPath.row-3].displaythumnail!)"
            let url:NSURL? = NSURL(string:string)
            cell.display.sd_setImageWithURL(url)
//            Alamofire.request(.GET, "http://cadenza.in.th/\(data_model[indexPath.row-3].displaythumnail!)")
//                .responseImage { response in
//                    if let image = response.result.value {
//                        dispatch_async(dispatch_get_main_queue(),{
//                          //  self.tableview.reloadData()
//                            cell.display.image = image
//                        })
//                        
//                    }
//            }
            cell.message.text = data_model[indexPath.row-3].topicReplyDes!
            cell.postby.text = "\(data_model[indexPath.row-3].author_fname!) \(data_model[indexPath.row-3].author_lname!)"
            return cell
        }
    }
    
    func topic(indexpPath:NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableview.dequeueReusableCellWithIdentifier("Topic")!
        // Configure the cell...
        cell.textLabel!.text = titlename
        cell.detailTextLabel!.text = "Post by \(postby!)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 10
        }else {
            //  print(UITableViewAutomaticDimension)
            return UITableViewAutomaticDimension
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath)->[UITableViewRowAction]?{
        if indexPath.row-3 > 0{
            if data_model[indexPath.row-3].author_fname == mystruct.pro_fname {
                //            let more = UITableViewRowAction(style: .Normal, title: "More") { action, index in
                //                print("more button tapped")
                //            }
                //            more.backgroundColor = UIColor.lightGrayColor()
                
                let Edit = UITableViewRowAction(style:.Normal, title: "Edit") { action, index in
                    //  print("Edit button tapped")
                    self.data_model[indexPath.row-3].topicDes = "edit"
                    print(self.data_model[indexPath.row-3].topicDes)
                }
                Edit.backgroundColor = UIColor.blueColor()
                
                let Delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
                    if mystruct.secID == nil {
                        self.alamo_delete("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.json_instruct![0,"SectionID"])/topics/\(mystruct.topicID!)/topicreplys/\(self.data_model[indexPath.row-3].topicReplyID!)")
                    }else{
                        self.alamo_delete("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.secID!)/topics/\(mystruct.topicID!)/topicreplys/\(self.data_model[indexPath.row-3].topicReplyID!)")
                    }
                    self.data_model.removeAtIndex(indexPath.row-3)
            //        self.tableview.reloadData()
                    //   print("share button tapped")
                }
                Delete.backgroundColor = UIColor.redColor()
                
                return [Delete, Edit]
            }else{
                return nil
            }
        }else{
            return nil
        }
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }

}
extension ReplyViewController : UITableViewDelegate {
    
}