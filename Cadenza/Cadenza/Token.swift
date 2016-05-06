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
//    func connect(){
//        Alamofire.request(.CONNECT,"http://www.cadenza.in.th/")
//            .responseJSON{ response in
//                print(response.)
//                
//        }
//    }
    func getProfile(){
//        if let a:String = getToken() {
//            print(a)
//        }
     //   connect()
        Alamofire.request(.GET,"http://www.cadenza.in.th/v2/api/mobile/profile?access_token=\(getToken())")
            .responseJSON{ response in
                UIApplication.sharedApplication().startNetworkActivity()
               // print(response.result.value!)
                if let _:AnyObject = response.result.value {
                    mystruct.pro_display = response.result.value!["display"] as? String
                    mystruct.pro_display_thumbnail = response.result.value!["display_thumbnail"] as? String
                    mystruct.pro_fname = response.result.value!["firstname"] as? String
                    mystruct.pro_lname = response.result.value!["lastname"] as? String
                }
                
                UIApplication.sharedApplication().stopNetworkActivity()
        }
    }
    func notification() {
        if mystruct.devicetoken == ""{
            
        }else{
            let data = ["access_token":"\(Token().getToken())","DeviceToken":"\(mystruct.devicetoken!)","DeviceOS":"ios"]
            Alamofire.request(.POST,"http://www.cadenza.in.th/v2/api/mobile/signin",parameters:data)

        }
    }
    func notification_logout() {
        if mystruct.devicetoken == ""{
            
        }else{
            let data = ["access_token":"\(Token().getToken())","DeviceToken":"\(mystruct.devicetoken!)"]
            Alamofire.request(.POST,"http://www.cadenza.in.th/v2/api/mobile/signout",parameters:data)
        }
    }
    func removetoken() {
        notification_logout()
        let appdel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appdel.managedObjectContext
        let request = NSFetchRequest(entityName: "Users")
        //   request.returnsObjectsAsFaults = false;
        do {
            var result = try context.executeFetchRequest(request)
            // for res in result {
            //     print(res)
            //   }
            for bas in result {
                context.deleteObject(bas as! NSManagedObject)
            }
            result.removeAll(keepCapacity: false)
            
            print("Logout")
            //    print(result.count)
            if result.count == 0 {
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
//                    self.presentViewController(viewController, animated: true, completion: nil)
//                })
            }
        } catch {
            print(error)
        }
    }


}