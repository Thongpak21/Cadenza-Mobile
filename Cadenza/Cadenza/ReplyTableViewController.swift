//
//  ReplyTableViewController.swift
//  Cadenza
//
//  Created by Thongpak on 4/27/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ReplyTableViewController: UITableViewController {
    var data_model = [model]()
    var titlename:String?
    var postby:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        postby = mystruct.topic_postby!
        titlename = mystruct.topictitle!
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)
        if mystruct.secID == nil {
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.json_instruct![0,"SectionID"])/topics/\(mystruct.topicID!)?access_token=\(Token().getToken())")
            
        }else{
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.secID!)/topics/\(mystruct.topicID!)?access_token=\(Token().getToken())")
        }
     //   self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alamo_Lecture(url:String){
       // print(url)
        Alamofire.request(.GET,url)
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
             //   print(response.result.value!["TopicTitle"])
                if let results = response.result.value!["topicreply"] as? [[String: AnyObject]] {
                    for i in results {
                //        print(i)
          //                  print("\(model(i).topicTitle)   --->  \(model(i).topicID)")
                        self.data_model.append(model(i))
                    }
                }
                UIApplication.sharedApplication().stopNetworkActivity()
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                })
        }
        
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("Topic", forIndexPath: indexPath)
            // Configure the cell...
            cell.textLabel!.text = titlename
            cell.detailTextLabel!.text = postby
        
            cell.layer.cornerRadius = 1.0
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.clearColor().CGColor
            cell.layer.masksToBounds = true
        
            cell.layer.shadowColor = UIColor.blackColor().CGColor
            cell.layer.shadowOffset = CGSizeMake(0, 1)
            cell.layer.shadowRadius = 1.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("Reply", forIndexPath: indexPath)
            // Configure the cell...
           // cell.textLabel?.text = data_model[indexPath.row].topicTitle
            return cell
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
