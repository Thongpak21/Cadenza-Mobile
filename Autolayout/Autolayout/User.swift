//
//  User.swift
//  Autolayout
//
//  Created by Thongpak on 9/26/2558 BE.
//  Copyright © 2558 Thongpak. All rights reserved.
//

import Foundation
struct User {
    let name: String
    let company:String
    let login:String
    let password:String
    static func login(login:String,passwd:String) ->User? {
        if let user = database[login] {
            if user.password == passwd {
                return user
            }
        }
        return nil
    }
    static let database:Dictionary<String,User> = {
        var theDatabase = Dictionary<String,User>()
        for user in [
            User(name: "Thongpak", company: "Apple", login: "eyeshield", password: "mamori")] {
                theDatabase[user.login] = user
        }
        return theDatabase
    }()
}