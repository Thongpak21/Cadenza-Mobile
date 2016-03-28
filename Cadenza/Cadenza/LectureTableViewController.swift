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
class LectureTableViewController: UITableViewController {
    var data_model = [model]()
    var Lecture = [String]()
    var update = [String]()
    var lectureID = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
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
                let json:JSON = JSON(response.result.value!)
                //   print(json)
                
                if json[0,"SectionID"] != nil {
                  //  print(json.count)
                    for i in 0...json.count-1 {
                        let user: Dictionary<String, JSON> = json[i].dictionaryValue
                        self.Lecture.append((user["LectureTitle"]?.string)!)
                        self.update.append((user["updated_at"]?.string)!)
                        self.lectureID.append((user["LectureID"]?.int)!)
                    }
          //          mystruct.json_lecture = json
                }else {
                  //  mystruct.json_lecture = nil
                    self.Lecture.append("No Lecture ")
                    self.update.append(" ")
                }
                UIApplication.sharedApplication().stopNetworkActivity()
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                })
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
        return Lecture.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = Lecture[indexPath.row]
        
        cell.detailTextLabel?.text = update[indexPath.row]
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        mystruct.lectureID = lectureID[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
