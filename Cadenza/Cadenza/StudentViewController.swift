//
//  StudentViewController.swift
//  Cadenza
//
//  Created by Thongpak on 5/11/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class StudentViewController: UIViewController {
    private var data_model = [model]()
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.labelText = "Loading"
        
        tableview.delegate = self
        tableview.dataSource = self
        if mystruct.secID == nil {
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.json_instruct![0,"SectionID"])/students?access_token=\(Token().getToken())")
            
        }else{
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.secID!)/students?access_token=\(Token().getToken())")
        }
    }
    func alamo_Lecture(url:String){
        Alamofire.request(.GET,url)
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
                if let results = response.result.value as? [[String: AnyObject]] {
                    for i in results {
                        //       print("\(model(i).LessonID)   --->  \(model(i).LessonTitle)")
               //         print(model(i).author_fname)
                        self.data_model.append(model(i))
                    }
                }
                self.tableview.reloadData()
                
                UIApplication.sharedApplication().stopNetworkActivity()
                
//                dispatch_async(dispatch_get_main_queue(),{
//                    self.tableview.reloadData()
//                })
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension StudentViewController:UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data_model.count == 0 {
            return 1
        }else{
            return data_model.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if data_model.count == 0 {
            cell.textLabel?.text = "No Students"
        }else{
            cell.textLabel?.text = "\(data_model[indexPath.row].author_fname!) \(data_model[indexPath.row].author_lname!)"
        }
        return cell
    }

    
}
extension StudentViewController:UITableViewDelegate{
    
}