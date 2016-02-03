//
//  Model.swift
//  Cadenza
//
//  Created by Thongpak on 2/4/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import Foundation
class model : NSObject {
    var title: String?
    var author: String?
    init(_ dictionary:[String: AnyObject]) {
        super.init()
        title = dictionary["title"] as? String
        author = dictionary["author"] as? String
        
    }
}