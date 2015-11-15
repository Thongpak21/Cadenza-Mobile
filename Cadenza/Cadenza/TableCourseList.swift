//
//  NewsTableViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableCourseList: UITableViewController {
    @IBOutlet var menuButton:UIBarButtonItem!
    @IBOutlet var extraButton:UIBarButtonItem!
    var coursename = [String]()
    var teacher = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
//            revealViewController().rearViewRevealWidth = 62
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"

            revealViewController().rightViewRevealWidth = 150
            extraButton.target = revealViewController()
            extraButton.action = "rightRevealToggle:"

            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        Alamofire.request(.GET, "http://cadenza.in.th/api/mobile/course" )
            .responseJSON { response in
                let json = JSON(response.result.value!)
                //   print("JSON: \(json)")
                //   print(json["data",0,"CourseName"])
                let num = (json["data"].array?.count)!
                if let ct:Int = num {
                    for index in 0...ct-1 {
                        if let name = json["data",index,"CourseName"].string {
                            let test:String = name
                            self.coursename.append(test)
                        }
                        let fname = json["data",index,"firstname"].string
                        let lname = json["data",index,"lastname"].string
                        let flname = fname! + " " + lname!
                        self.teacher.append(flname)
                        
                    }
                    dispatch_async(dispatch_get_main_queue(),{
                        self.tableView.reloadData()
                    })
                }
                //                for (key,json):(String, JSON) in json {
                //                    print("\(key) -> \(json)")
                //                    if key == "data" {
                //                        print("\(key) -> \(json)")
                //                    }
                //                }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return coursename.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! NewsTableViewCell

        // Configure the cell...
//        if indexPath.row == 0 {
//            cell.postImageView.image = UIImage(named: "watchkit-intro")
//            cell.postTitleLabel.text = "WatchKit Introduction: Building a Simple Guess Game"
//            cell.authorLabel.text = "Simon Ng"
//            cell.authorImageView.image = UIImage(named: "author")
//
//        } else if indexPath.row == 1 {
//            cell.postImageView.image = UIImage(named: "custom-segue-featured-1024")
//            cell.postTitleLabel.text = "Building a Chat App in Swift Using Multipeer Connectivity Framework"
//            cell.authorLabel.text = "Gabriel Theodoropoulos"
//            cell.authorImageView.image = UIImage(named: "appcoda-300")
//            
//        } else {
//            cell.postImageView.image = UIImage(named: "webkit-featured")
//            cell.postTitleLabel.text = "A Beginner’s Guide to Animated Custom Segues in iOS 8"
//            cell.authorLabel.text = "Gabriel Theodoropoulos"
//            cell.authorImageView.image = UIImage(named: "appcoda-300")
//            
//        }
        cell.postTitleLabel.text = coursename[indexPath.row]
        cell.authorLabel.text = teacher[indexPath.row]
        cell.postImageView.image = UIImage(named: "watchkit-intro")
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
