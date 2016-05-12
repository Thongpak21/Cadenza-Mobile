//
//  AssignmentViewController.swift
//  Cadenza
//
//  Created by Thongpak on 5/11/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
class AssignmentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var assign_title = [String]()
    var update = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        //   hud.mode = MBProgressHUDMode.Indeterminate
        hud.labelText = "Loading"
        fetchdata()
        // Do any additional setup after loading the view.
        tableview.delegate = self
        tableview.dataSource = self
    }
    func fetchdata() {
        Alamofire.request(.GET,"http://www.cadenza.in.th/v2/api/mobile/assignments?access_token=\(Token().getToken())")
            .responseJSON{ response in
            //    print(Any)
                let a = response.result.value!.count-1
                let json = JSON(response.result.value!)
                for w in 0...a {
               //     print(json[w]["assignment"]["AssignmentTitle"])
                    self.assign_title.append(json[w]["assignment"]["AssignmentTitle"].string!)
                    self.update.append(json[w]["assignment"]["updated_at"].string!)
                }
//                for w in 0...a {
//                    if let result = response.result.value as? [[String:AnyObject]]{
//                       // print(result[w]["assignment"]!["AssignmentTitle"])
//                      //  let a = ["AssignmentTitle":"\(result[w]["assignment"]!["AssignmentTitle"].string)","updated_at":"\(result[w]["assignment"]!["updated_at"].string)"]
//                        
//                        self.assign_title.append("\(result[w]["assignment"]!["AssignmentTitle"])")
//                        self.update.append("\(result[w]["assignment"]!["updated_at"])")
//                       // data_model.append(model(a))
//                    }
//                
//                }
                dispatch_async(dispatch_get_main_queue(),{
                                            self.tableview.reloadData()
                    
                                        })
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
         //       self.tableview.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print(assign_title.count)
        tabBarController?.tabBar.items?[2].badgeValue = "\(assign_title.count)"
        return assign_title.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    //    print(assign_title[indexPath.row])
        cell.textLabel?.text = assign_title[indexPath.row]
        cell.detailTextLabel?.text = update[indexPath.row]
        return cell
    }

}
