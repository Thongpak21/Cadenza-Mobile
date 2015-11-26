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
class Login: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginController()
        Alamofire.request(.GET, "http://www.cadenza.in.th/images/Logo_Cadenza_8.png")
            .responseImage { response in
//                debugPrint(response)
//                print(response.request)
//                print(response.response)
//                debugPrint(response.result)
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    self.image.image = image.af_imageWithRoundedCornerRadius(20.0)
//                     self.image.image = image.af_imageRoundedIntoCircle()
                    
                }
               
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LoginController() {
        password.secureTextEntry = true
    }
    
    
    @IBAction func LoginAction(sender: UIButton) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") 
            self.presentViewController(viewController, animated: true, completion: nil)
        })
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
