//
//  LectureTableViewController.swift
//  Cadenza
//
//  Created by Thongpak on 3/22/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CarbonKit
import MBProgressHUD
class LectureTableViewController: UITableViewController {
    var data_model = [model]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.labelText = "Loading"
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)
       // print(mystruct.secID)
 //       print(mystruct.json_instruct![0,"SectionID"])
        if mystruct.secID == nil {
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.json_instruct![0,"SectionID"])/lectures?access_token=\(Token().getToken())")

        }else{
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.secID!)/lectures?access_token=\(Token().getToken())")
        }
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    func alamo_Lecture(url:String){
        Alamofire.request(.GET,url)
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
                if let results = response.result.value as? [[String: AnyObject]] {
                    for i in results {
                 //       print("\(model(i).LessonID)   --->  \(model(i).LessonTitle)")
                        self.data_model.append(model(i))
                    }
                }
                
                UIApplication.sharedApplication().stopNetworkActivity()
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                })
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if data_model.count == 0{
            return 1
        }else{
            return data_model.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if data_model.count == 0 {
            cell.textLabel?.text = "No Lecture!!!"
            cell.detailTextLabel?.text = ""
            return cell
        }else {
            cell.textLabel?.text = data_model[indexPath.row].lectureTitle
            cell.detailTextLabel?.text = data_model[indexPath.row].update
            return cell
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if data_model.count == 0 {
            
        }else{
            mystruct.lectureID = data_model[indexPath.row].lectureID
            
            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Lesson") as! LessonTableViewController
            
            self.navigationController!.pushViewController(secondViewController, animated: true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
