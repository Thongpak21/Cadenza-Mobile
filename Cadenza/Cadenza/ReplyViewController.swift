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
    var data_model = [model]()

    
    @IBOutlet weak var Postby: UILabel!
    
    @IBOutlet weak var titlename: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titlename.text = mystruct.topictitle
        Postby.text = mystruct.topic_postby
        if mystruct.secID == nil {
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.json_instruct![0,"SectionID"])/topics/\(mystruct.topicID!)?access_token=\(Token().getToken())")
            
        }else{
            alamo_Lecture("http://www.cadenza.in.th/v2/api/mobile/courses/\(mystruct.courseID!)/sections/\(mystruct.secID!)/topics/\(mystruct.topicID!)?access_token=\(Token().getToken())")
        }
        
    }
    func alamo_Lecture(url:String){
        // print(url)
        Alamofire.request(.GET,url)
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
            //    print(response.result.value!["TopicTitle"])
                if let results = response.result.value!["topicreply"] as? [[String: AnyObject]] {
                    for i in results {
                        //                  print("\(model(i).topicTitle)   --->  \(model(i).topicID)")
                        self.data_model.append(model(i))
                    }
                }
                
                
                
                UIApplication.sharedApplication().stopNetworkActivity()
                
                dispatch_async(dispatch_get_main_queue(),{
                  //  self.tableView.reloadData()
                })
        }
        
    }

   
}
//extension ReplyViewController : UITableViewDataSource{
//}
