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
    var author_fname: String?
    var author_lname: String?
    var courseID : Int?
    var courseDes: String?
    var courseCoverFull : String?
    var courseCoverThumb : String?
    var test : String?
    var numpage :Int?
    var sections = [String]()
    init(_ dictionary:[String: AnyObject]) {
        super.init()
        title = dictionary["CourseName"] as? String
        author_fname = dictionary["firstname"] as? String
        author_lname = dictionary["lastname"] as? String
        courseID = dictionary["CourseID"] as? Int
        courseDes = dictionary["CourseDescription"] as? String
        courseCoverFull = dictionary["CourseCoverFull"] as? String
        courseCoverThumb = dictionary["CourseCoverThumbnail"] as? String
        test = dictionary["coursecategory"] as? String
        numpage = dictionary["last_page"] as? Int
    } 
}
