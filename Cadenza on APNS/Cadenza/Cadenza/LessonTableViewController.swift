//
//  LessonTableViewController.swift
//  Cadenza
//
//  Created by Thongpak on 3/28/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire

class LessonTableViewController: UITableViewController {

    var data_model = [model]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)
//        print(mystruct.courseID)
//        print(mystruct.secID)
//        print(mystruct.lectureID)
        if mystruct.secID == nil {
            alamo_Lesson("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.json_instruct![0,"SectionID"])/lectures/\(mystruct.lectureID!)/lessons?access_token=\(Token().getToken())")
            
        }else{
            alamo_Lesson("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.secID!)/lectures/\(mystruct.lectureID!)/lessons?access_token=\(Token().getToken())")
        }

    }
    func alamo_Lesson(url:String){
        Alamofire.request(.GET,url)
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
                if let results = response.result.value as? [[String: AnyObject]] {
                    for i in results {
             //           print("\(model(i).LessonID)   --->  \(model(i).LessonTitle)")
                        self.data_model.append(model(i))
                    }
                    self.tableView.reloadData()
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data_model.count == 0 {
            return 1
        }else{
            return data_model.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if data_model.count == 0 {
            cell.textLabel?.text = ""
            return cell
        }else{
            let data_cell = data_model[indexPath.row]
            cell.textLabel?.text = data_cell.LessonTitle
            return cell
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        mystruct.Lessondes = data_model[indexPath.row].LessonDes
    }


}
