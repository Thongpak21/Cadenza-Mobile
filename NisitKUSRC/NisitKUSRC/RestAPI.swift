//
//  RestAPI.swift
//  NisitKUSRC
//
//  Created by Thongpak on 6/14/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import Foundation
import Alamofire

func GradeAPI()  {
    Alamofire.request(.GET, Grade_URL, encoding: .JSON)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .Success:
                print(response.result.value)
            case .Failure(let error):
                print(error)
            }
          //  return response
    }
}