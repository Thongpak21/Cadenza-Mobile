//
//  ViewController.swift
//  Coredata
//
//  Created by Thongpak on 10/5/2558 BE.
//  Copyright © 2558 Thongpak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    @IBAction func btn(sender: AnyObject) {
        let appdel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appdel.managedObjectContext
        let newtoken = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        newtoken.setValue("test", forKey: "username")
        //      context.save(nil)
        print(newtoken)
    }
}

