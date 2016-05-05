//
//  LogoutController.swift
//  Cadenza
//
//  Created by Thongpak on 11/28/2558 BE.
//  Copyright © 2558 Thongpak. All rights reserved.
//

import UIKit
import CoreData
class LogoutController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Token().notification_logout()
        removetoken()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func removetoken() {
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
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                    self.presentViewController(viewController, animated: true, completion: nil)
                })
            }
        } catch {
            print(error)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
