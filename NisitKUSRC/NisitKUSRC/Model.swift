//
//  Model.swift
//  NisitKUSRC
//
//  Created by Thongpak on 6/11/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
import ObjectMapper

class Model: Mappable {
    var field:String?
    var time:String?
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        field <- map["field1"]
        time <- map["created_at"]
    }
}
