//
//  MyProfileViewModel.swift
//  MVVM
//
//  Created by Thongpak on 7/26/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import Foundation
class MyProfileViewModel:NSObject {
    var interactor:MyProfileProtocol?
    var delegate:ViewModelDelegate?
    var myProFileModel:MyProFileModel?
    
    convenience init(delegate: ViewModelDelegate) {
        self.init()
        self.delegate = delegate
        self.interactor = MyProfileInteractor()
    }
    func usingInteractor(interactor: MyProfileProtocol) {
        self.interactor = interactor
    }
    func refreshData() {
        self.interactor!.getResponseWithComplete({(response:MyProFileModel) -> Void in
            self.myProFileModel = response
            self.delegate!.onDataDidLoad()
            }, andError: {(errorMessage: String) -> Void in
                self.delegate!.onDataDidLoadErrorWithMessage(errorMessage)
        })
    }
    func numberOfArray() -> Int {
        return (self.myProFileModel?.authorized?.count)!
    }
    func wordForIndex(index: Int) -> MyProFileModel {
        return self.myProFileModel!
    }
}