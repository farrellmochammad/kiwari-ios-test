//
//  Contact.swift
//  kiwari-ios-test
//
//  Created by farrell mochammad on 03/12/19.
//  Copyright © 2019 farrell mochammad. All rights reserved.
//

import Foundation

class Contact {
    var chat_id: String?
    var friend_avatar: String?
    var friend_email: String?
    var friend_name: String?
    var last_chat: String?
    
    init(chat_id: String, friend_avatar: String,friend_email:String,friend_name: String,last_chat: String){
        self.chat_id = chat_id
        self.friend_avatar = friend_avatar
        self.friend_email = friend_email
        self.friend_name = friend_name
        self.last_chat = last_chat
    }
}
