//
//  Q&ATableViewController.swift
//  Cadenza
//
//  Created by Thongpak on 4/20/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
class QATableViewController: UITableViewController {
    var data_model = [model]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)

        
        if mystruct.secID == nil {
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.json_instruct![0,"SectionID"])/topics?access_token=\(Token().getToken())")
            
        }else{
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.secID!)/topics?access_token=\(Token().getToken())")
        }
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        
//        self.tableView.setNeedsLayout()
//        self.tableView.layoutIfNeeded()
    //    tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    func alamo_Lecture(url:String){
        Alamofire.request(.GET,url)
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
                if let results = response.result.value as? [[String: AnyObject]] {
                    for i in results {
                        //    print("\(model(i).LessonID)   --->  \(model(i).LessonTitle)")
                        self.data_model.append(model(i))
                    }
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
        return data_model.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! QATableViewCell
        cell.title.text = data_model[indexPath.row].topicTitle
        cell.numreply!.text = "\(data_model[indexPath.row].numreply!) Reply"
        cell.name!.text = "\(data_model[indexPath.row].author_fname!) \(data_model[indexPath.row].author_lname!)"
        cell.update!.text = data_model[indexPath.row].update!
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        mystruct.topictitle = data_model[indexPath.row].topicTitle!
        mystruct.topicID = data_model[indexPath.row].topicID!
        mystruct.topic_postby = "\(data_model[indexPath.row].author_fname!) \(data_model[indexPath.row].author_lname!)"
        mystruct.reply = data_model[indexPath.row].numreply!
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
