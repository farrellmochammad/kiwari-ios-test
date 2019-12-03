//
//  Contact.swift
//  kiwari-ios-test
//
//  Created by farrell mochammad on 03/12/19.
//  Copyright © 2019 farrell mochammad. All rights reserved.
//

import Foundation

class Contact {
    var friend_avatar: String?
    var friend_name: String?
    var last_chat: String?
    
    init(friend_avatar: String,friend_name: String,last_chat: String){
        self.friend_avatar = friend_avatar
        self.friend_name = friend_name
        self.last_chat = last_chat
    }
}