//
//  ViewController.swift
//  NisitKUSRC
//
//  Created by Thongpak on 6/9/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let vc = GradeViewController(nibName: "TestViewController", bundle: nil);
        navigationController?.pushViewController(vc, animated: true);
        
     //   self.navigationController!.pushViewController(GradeViewController(nibName: "TestViewController", bundle: nil), animated: true );
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

