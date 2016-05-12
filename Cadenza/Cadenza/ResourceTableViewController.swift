//
//  ResourceTableViewController.swift
//  Cadenza
//
//  Created by Thongpak on 5/1/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class ResourceTableViewController: UITableViewController {
    var data_model = [model]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)
        // print(mystruct.secID)
        //       print(mystruct.json_instruct![0,"SectionID"])
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        //   hud.mode = MBProgressHUDMode.Indeterminate
        hud.labelText = "Loading"
        if mystruct.secID == nil {
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.json_instruct![0,"SectionID"])/resources?access_token=\(Token().getToken())")
            
        }else{
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.secID!)/resources?access_token=\(Token().getToken())")
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
            cell.textLabel?.text = "No ResourceFile!!!"
            cell.detailTextLabel?.text = ""
            return cell
        }else {
            cell.textLabel?.text = data_model[indexPath.row].resourceTitle
            cell.detailTextLabel?.text = data_model[indexPath.row].update
            return cell
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if data_model.count == 0 {
            
        }else{
            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("resoucefile") as! ResouceFileViewController
            
            self.navigationController!.pushViewController(secondViewController, animated: true)
//            print("http://cadenza.in.th/download/\(data_model[indexPath.row].resourceFile!)")
//            Alamofire.download(.GET, "http://cadenza.in.th/download/\(data_model[indexPath.row].resourceFile!)") { temporaryURL, response in
//                let fileManager = NSFileManager.defaultManager()
//                let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
//                let pathComponent = response.suggestedFilename
//                
//                return directoryURL.URLByAppendingPathComponent(pathComponent!)
//            }
           // print(data_model[indexPath.row].resourceFile)
            mystruct.resourceFile = "http://cadenza.in.th/download/\(data_model[indexPath.row].resourceFile!)"
//            let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
//            Alamofire.download(.GET, "http://cadenza.in.th/download/\(data_model[indexPath.row].resourceFile!)", destination: destination)
//                .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
//                    print(totalBytesRead)
//                    
//                    // This closure is NOT called on the main queue for performance
//                    // reasons. To update your ui, dispatch to the main queue.
//                    dispatch_async(dispatch_get_main_queue()) {
//                        print("Total bytes read on main queue: \(totalBytesRead)")
//                    }
//                }
//                .response { _, _, _, error in
//                    if let error = error {
//                        print("Failed with error: \(error)")
//                    } else {
//                        print("Downloaded file successfully")
//                    }
//            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

