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
    var sectionName: String?
    var sectionID:Int?
    var sectionToken:String?
    var lectureID:Int?
    var lectureTitle:String?
    var courseEnroll : String?
    var update:String?
    var annoID: Int?
    var annoTitle:String?
    var annoDes:String?
    var LessonID:Int?
    var LessonTitle:String?
    var LessonDes:String?
    var videoID:Int?
    var videoTitle:String?
    var videoURL:String?
    var videoType:Int?
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
        sectionName = dictionary["SectionName"] as? String
        sectionID = dictionary["SectionID"] as? Int
        sectionToken = dictionary["SectionToken"] as? String
        lectureID = dictionary["LectureID"] as? Int
        lectureTitle = dictionary["LectureTitle"] as? String
        courseEnroll = dictionary["courseenroll"] as? String
        annoID = dictionary["AnnounceID"] as? Int
        annoTitle = dictionary["AnnounceTitle"] as? String
        annoDes = dictionary["AnnounceDescription"] as? String
        LessonID = dictionary["LessonID"] as? Int
        LessonTitle = dictionary["LessonTitle"] as? String
        LessonDes = dictionary["LessonDescription"] as? String
        videoID = dictionary["VideoID"] as? Int
        videoTitle = dictionary["VideoTitle"] as? String
        videoURL = dictionary["VideoURL"] as? String
        videoType = dictionary["VideoType"] as? Int
        update = dictionary["updated_at"] as? String
    }
}