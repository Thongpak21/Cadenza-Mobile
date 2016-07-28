//
//  myProfileModel.swift
//  MVVM
//
//  Created by Thongpak on 7/26/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import Foundation
import ObjectMapper

class MyProFileModel : Mappable {
    
    
    var resultCode:String?
    var resultDesc:String?
    var devMessage:String?
    
    var subData:ProfileData?
    var numOfData:ProfileNumOfData?
    var authorized:[AuthorData]?
    required init(_ map: Map) {
        
    }
    func mapping(map: Map) {
        resultCode <- map["resultCode"]
        resultDesc <- map["resultDesc"]
        devMessage <- map["developerMessage"]
        subData <- map["data"]
        authorized <- map["authorizedNumbers"]
    }
    
}


class ProfileData: Mappable {
    var object:String?
    var currentNetType:String?
    
    required init(_ map: Map) {
        
    }
    func mapping(map: Map) {
        object <- map["object"]
        currentNetType <- map["currentNetworkType"]
    }
}


class ProfileNumOfData: Mappable {
    var object:String?
    var regisName:String?
    var priviType:String?
    var priviStatus:String?
    var regisOn:String?
    var mobiServiceYear:String?
    var internetChargeType:String?
    var suspensionStatusFlag:Bool?
    var email:String?
    required init(_ map: Map) {
        
    }
    func mapping(map: Map) {
        object <- map["object"]
        regisName <- map["registeredName"]
        priviType <- map["privilegeType"]
        priviStatus <- map["privilegeStatus"]
        regisOn <- map["registeredOn"]
        mobiServiceYear <- map["mobileServiceYear"]
        
    }
}
class AuthorData: Mappable {
    var key1:String?
    var key2:String?
    var key3:String?
    var key4:String?
    var key5:String?
    
    required init(_ map: Map) {
        
    }
    func mapping(map: Map) {
        key1 <- map["key1"]
        key2 <- map["key2"]
        key3 <- map["key3"]
        key4 <- map["key4"]
        key5 <- map["key5"]
    }
    
}