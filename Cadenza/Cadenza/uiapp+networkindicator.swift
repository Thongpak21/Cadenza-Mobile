//
//  uiapp+networkindicator.swift
//  Cadenza
//
//  Created by Thongpak on 2/4/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import Foundation
private var networkActivityCount = 0

extension UIApplication {
    
    func startNetworkActivity() {
        networkActivityCount += 1
        networkActivityIndicatorVisible = true
    }
    
    func stopNetworkActivity() {
        if networkActivityCount < 1 {
            return;
        }
        
        if --networkActivityCount == 0 {
            networkActivityIndicatorVisible = false
        }
    }
    
}