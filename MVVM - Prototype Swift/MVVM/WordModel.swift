//
//  WordModel.swift
//  MVVM
//
//  Created by Thongpak on 7/26/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import Foundation
class WordModel:NSObject {
    
    var title:String?

     init(_ dictionary:[String:AnyObject]) {
        super.init()
        title = dictionary["word"] as? String
    }
}