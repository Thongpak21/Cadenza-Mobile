//
//  Login.swift
//  Cadenza
//
//  Created by Thongpak on 11/22/2558 BE.
//  Copyright © 2558 Thongpak. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
import CoreData
class Login: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        checktoken()
        LoginController()
        username.delegate = self
        password.delegate = self
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
    //    textField.resignFirstResponder()
        if textField == self.username {
            self.password.becomeFirstResponder()
        }
        if textField == self.password {
            textField.resignFirstResponder()
        }
        return true
    }
    func LoginController() {
        password.secureTextEntry = true
    }
    func checktoken() {
        let appdel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appdel.managedObjectContext
        let request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false;
        do {
            let result = try context.executeFetchRequest(request)
//             for res in result {
//                 print(res)
//               }
            print("login")
            print(result)
            if result.count != 0 {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
                    self.presentViewController(viewController, animated: true, completion: nil)
                })
            }
        } catch {
               print(error)
        }
        
    }

    
    @IBAction func LoginAction() {
        
        
        let data = [
            "grant_type": "password",
            "client_id":"client1id",
            "client_secret":"client1secret",
              "username":"demo3@cadenza.in.th",
              "password":"demo3"
//            "username":username.text!,
//            "password":password.text!
        ]
        Alamofire.request(.POST, "http://cadenza.in.th/oauth/access_token",parameters:data )
            .responseJSON { response in
//                print("Response JSON: \(response.result.value)")
                let json = JSON(response.result.value!)
          //      print(json["access_token"])
//                for (key,json):(String, JSON) in json {
//                    print("\(key) -> \(json)")
//                }
                if json["access_token"] == nil {
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
                let appdel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                let context:NSManagedObjectContext = appdel.managedObjectContext
                
                let newtoken = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) // as NSManagedObject
                newtoken.setValue("\(json["access_token"])", forKey: "token")
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print("could not save \(error)")
                }
                print(newtoken)
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
