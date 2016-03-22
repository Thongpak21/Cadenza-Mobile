//
//  Token.swift
//  Cadenza
//
//  Created by Thongpak on 3/22/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import CoreData
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

}
