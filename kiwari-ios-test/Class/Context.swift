//
//  Chat.swift
//  kiwari-ios-test
//
//  Created by farrell mochammad on 04/12/19.
//  Copyright © 2019 farrell mochammad. All rights reserved.
//

import Foundation

class Context {
    var context: String?
    var from: String?
    var date: String?
    
    init(context: String, from: String,date: String){
        self.context = context
        self.from = from
        self.date = date
    }
}
