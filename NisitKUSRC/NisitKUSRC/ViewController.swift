//
//  ViewController.swift
//  NisitKUSRC
//
//  Created by Thongpak on 6/9/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    var data = [Model]()
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        Alamofire.request(.GET,"https://thingspeak.com/channels/9/field/1.json")
            .responseJSON{ response in
                if let result = response.result.value!["feeds"] as? [[String: AnyObject]] {
                    for i in result {
                        //     print("\((Model(i).field1?.intValue)! + 100)")
                        self.data.append(Model(JSON: i)!)
                        print(Model(JSON: i)!.field)
                    }
                    
                }
        }
       // print(data[1].field)
=======
        // Do any additional setup after loading the view, typically from a nib.
        
        let vc = GradeViewController(nibName: "TestViewController", bundle: nil);
        navigationController?.pushViewController(vc, animated: true);
        
     //   self.navigationController!.pushViewController(GradeViewController(nibName: "TestViewController", bundle: nil), animated: true );
        

>>>>>>> b7bc532b043b29d4c0712cecba7d865e48a47d86
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

