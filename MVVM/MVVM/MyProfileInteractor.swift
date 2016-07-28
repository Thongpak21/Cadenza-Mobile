//
//  MyProfileInteractor.swift
//  MVVM
//
//  Created by Thongpak on 7/26/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


class MyProfileInteractor : MyProfileProtocol {
    
    func getResponseWithComplete(completion: OnDataComplete, andError error: OnDataError) {
        Alamofire.request(.GET, "http://45.32.24.218:8081/service/test/0926621664")
            .validate()
            .responseObject { (response: Response<MyProFileModel,NSError>) in
                switch response.result {
                case .Success:
                    completion(response: response.result.value!)
                case .Failure(let errorM):
                    error(errorMessage: "get data fail. \(errorM)")
                }
            }
    }
}