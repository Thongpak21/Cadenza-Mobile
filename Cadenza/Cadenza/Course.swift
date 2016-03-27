//
//  Course.swift
//  Cadenza
//
//  Created by Thongpak on 3/23/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

struct mystruct {
    static var courseID:Int?
    static var secID:Int?
    static var indexPath:Int?
    static var json:JSON?
    static var json_instruct:JSON?
    static var update_lec = [String]()
    static var lecturetitle = [String]()
    static var json_lecture:JSON?
}
class getAPI {
    func alamo_Anno(url:String) {
         let task = Alamofire.request(.GET,url)
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
                let json:JSON = JSON(response.result.value!)
                print(json)
                
                UIApplication.sharedApplication().stopNetworkActivity()

        }
   //     let delay = ((mystruct.json_lecture?.count)! == 0 ? 0 : 5) * Double(NSEC_PER_SEC)
     //   let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_async(dispatch_get_main_queue(), {
            task.resume()
        })
        
    }
}