//
//  Token.swift
//  Cadenza
//
//  Created by Thongpak on 3/22/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
class Token: NSObject {
    func checktoken() -> AnyObject {
        let appdel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appdel.managedObjectContext
        let request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false;
        do {
            let result = try context.executeFetchRequest(request)
            
            // print(result)
            return result
        } catch {
            print(error)
        }
        return "no"
        
    }
    func getToken() -> String {
        let gToken:AnyObject = Token().checktoken()
        var token = gToken.valueForKey("token")
        token = token![0]
        return token! as! String
    }
    func getProfile(){
        Alamofire.request(.GET,"http://www.cadenza.in.th/v2/api/mobile/profile?access_token=\(getToken())")
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
               // print(response.result.value!)
                mystruct.pro_display = response.result.value!["display"] as? String
                mystruct.pro_display_thumbnail = response.result.value!["display_thumbnail"] as? String
                mystruct.pro_fname = response.result.value!["firstname"] as? String
                mystruct.pro_lname = response.result.value!["lastname"] as? String
                UIApplication.sharedApplication().stopNetworkActivity()
        }
    }

}