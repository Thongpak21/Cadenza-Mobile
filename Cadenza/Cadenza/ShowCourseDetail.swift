//
//  ShowCourseDetail.swift
//  Cadenza
//
//  Created by Thongpak on 1/27/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ShowCourseDetail: UIViewController,UIScrollViewDelegate{

    @IBOutlet weak var viaSegueLabel: UILabel!
    @IBOutlet weak var DescripLabel: UILabel!
    @IBOutlet weak var imgcov: UIImageView!
    var viaSegue = ""
    var Name = ""
    var teacher = ""
    var coveimg = ""
    var des = ""
    var url = "http://cadenza.in.th/api/mobile/course/show/"
    override func viewDidLoad() {
        super.viewDidLoad()
        viaSegueLabel.text = Name
        print(viaSegue)
        print(Name)
        print(teacher)
        print(coveimg)
        url = "http://cadenza.in.th/api/mobile/course/show/"+"\(viaSegue)"
        Alamofire.request(.GET, "\(url)")
        .responseJSON { response in
       //     print(response.result.value)
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json["CourseDescription"])
             //   self.DescripLabel.text = json["CourseDescription"].string
            }
            

        }
        Alamofire.request(.GET, coveimg)
            .responseImage { response in
                if let image = response.result.value {
                    self.imgcov.image = image
                }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
