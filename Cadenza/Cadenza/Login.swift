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
class Login: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginController()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LoginController() {
        password.secureTextEntry = true
   

    }
    
    
    @IBAction func LoginAction(sender: UIButton) {
        
        
        let data = [
            "grant_type": "password",
            "client_id":"client1id",
            "client_secret":"client1secret",
            //  "username":"demo3@cadenza.in.th",
            //  "password":"demo3"
            "username":username.text!,
            "password":password.text!
        ]
        Alamofire.request(.POST, "http://cadenza.in.th/oauth/access_token",parameters:data )
            .responseJSON { response in
//                print("Response JSON: \(response.result.value)")
                let json = JSON(response.result.value!)
                print(json["access_token"])
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
