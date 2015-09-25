import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let parameters = [
            "grant_type": "password",
            "client_id":"client1id",
            "client_secret":"client1secret",
            "username":"demo1@cadenza.in.th",
            "password":"demo1"
        ]
        Alamofire.request(.POST, "http://makeshop.in.th/oauth/access_token", parameters: parameters,encoding: .JSON)
            .response { request, response, data, error in
                //                print(request)
                //      print(response)
                //   print(error)
            }
            .responseString { _, _, result in
                //            print("Success: \(result.isSuccess)")
                //      print("Response String: \(result.value)")
                //          print(result)
                
            }
            .responseJSON { _, _, result in
                print("Response JSON: \(result.value)")
                let json = JSON(result.value!)
                print(json["access_token"])
                for (key,json):(String, JSON) in json {
                    print("\(key) -> \(json)")
                }
        }
    }
}

