//
//  Model.swift
//  NisitKUSRC
//
//  Created by Thongpak on 6/14/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import Foundation
import ObjectMapper

class GradeModel : Mappable {

    var grade:String?
    var id:String?
    required convenience init?(_ map: Map) {
        self.init()
    }
    func mapping(map: Map) {

        grade <- map["grade"]
        id <- map["id"]
    }
}