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

class ReplyViewController: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var tableview: UITableView!
    var data_model = [model]()
    var titlename:String?
    var postby:String?
    var topicdes:String?
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.clearsSelectionOnViewWillAppear = true
        postby = mystruct.topic_postby!
        titlename = mystruct.topictitle!
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
    @IBAction func post(sender: AnyObject) {
        let a = ["TopicReplyID": 108, "TopicReplyDescription": "สวัสดี", "TopicID": 5, "UserID": 2, "lastname": "Uengpaporn", "display_thumbnail": "/images/avatar/thumb_jhrldNOJrhvEkthS.jpg", "firstname": "Tachakorn"]
        data_model.append(model(a))
        //  print(model(a).topicReplyDes)
        //  let rth = tableView.dequeueReusableCellWithIdentifier("postreply") as! PostReplyTableViewCell
        //  print(rth.textfield.text)
        tableview.beginUpdates()
        tableview.insertRowsAtIndexPaths([NSIndexPath(forRow: data_model.count, inSection: 0)
            ], withRowAnimation: UITableViewRowAnimation.Bottom)
        tableview.endUpdates()
        
    }
    func alamo_Lecture(url:String){
        // print(url)
        Alamofire.request(.GET,url)
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
                //   print(response.result.value!["TopicTitle"])
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
            //      cell.layer.rowhe
            
            cell.textLabel?.text = ""
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("message", forIndexPath: indexPath)
            cell.textLabel?.text = topicdes
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("reply", forIndexPath: indexPath) as! ReplyTableViewCell
            Alamofire.request(.GET, "http://cadenza.in.th/\(data_model[indexPath.row-3].displaythumnail!)")
                .responseImage { response in
                    if let image = response.result.value {
                        cell.display.image = image
                    }
            }
            cell.message.text = data_model[indexPath.row-3].topicReplyDes!
            cell.postby.text = "\(data_model[indexPath.row-3].author_fname!) \(data_model[indexPath.row-3].author_lname!)"
            return cell
        }
    }
    
    func topic(indexpPath:NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableview.dequeueReusableCellWithIdentifier("Topic")!
        // Configure the cell...
        cell.textLabel!.text = titlename
        cell.detailTextLabel!.text = postby
        
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

}
extension ReplyViewController : UITableViewDelegate {
    
}