//
//  Publishers.swift
//  Cadenza
//
//  Created by Thongpak on 2/6/2559 BE.
//  Copyright © 2559 Thongpak. All rights reserved.
//

import UIKit
class Publishers:NSObject {
    private var publishers = [Publisher]()
    private var immutablePublishers = [Publisher]()
    private var sections = [String]()
    
    var numberOfPublishers: Int {
        return publishers.count
    }
    var numberOfSections: Int {
        return sections.count
    }
    override init() {
     //   publishers = createPublishers()
        immutablePublishers = publishers
        sections = ["My Favorites","Politics","Travel","Technology"]
    }
    func deleteItemAtindexPaths(indexPaths: [NSIndexPath]) {
        
    }
}
