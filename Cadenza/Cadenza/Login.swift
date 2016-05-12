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
import IQKeyboardManagerSwift
class Login: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        username.delegate = self
        password.delegate = self
        username.attributedPlaceholder = NSAttributedString(string:"Username",
                                                               attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        password.attributedPlaceholder = NSAttributedString(string:"Password",
                                                            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Login.dismissKeyboard))
        view.addGestureRecognizer(tap)
        IQKeyboardManager.sharedManager().disabledToolbarClasses.insert(NSStringFromClass(Login))
        checktoken()
        LoginController()
        
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func signup() {
        let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("register") as! RegisterViewController
        self.navigationController!.pushViewController(secondViewController, animated: true)
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
      //      print("login")
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
//              "username":"demo3@cadenza.in.th",
//              "password":"demo3"
            "username":username.text!,
            "password":password.text!
        ]
        Alamofire.request(.POST, "http://cadenza.in.th/oauth/access_token",parameters:data )
            .responseJSON { response in
//                print("Response JSON: \(response.result.value)")
                let json = JSON(response.result.value!)

                if json["access_token"] == nil {
                    let alert = UIAlertController(title: "Warning", message: "Username or Password is wrong.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                } else {
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
                    if let _:String! = Token().getToken() {
                        Token().notification()
                    }

                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
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
