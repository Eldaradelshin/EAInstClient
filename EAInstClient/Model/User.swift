//
//  User.swift
//  EAInstClient
//
//  Created by rushan adelshin on 21.08.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation

struct User {
    let identifier: Int
    let userName: String
    let avatarImageURL: String
    let fullName: String


     init(dictionary: [String:Any]) {
        self.identifier = dictionary["id"] as! Int
        self.userName = dictionary["username"] as! String
        self.avatarImageURL = dictionary["profile_picture"] as! String
        self.fullName = dictionary["full_name"] as! String
        
    }


}
