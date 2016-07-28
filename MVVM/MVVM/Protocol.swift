//
//  ViewModelDelegate.swift
//  MVVM
//
//  Created by Thongpak on 7/26/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import Foundation
protocol ViewModelDelegate {
    func onDataDidLoad() -> Void
    func onDataDidLoadErrorWithMessage(errorMessage:String) -> Void
}