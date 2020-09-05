//
//  User.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/09/01.
//  Copyright © 2020 한상현. All rights reserved.
//

import Foundation

struct User {
    static var shared = User()
    
    private init() {}
    
    private var userIdToken: String?
    private var connectionToken: String?
    
    mutating func setUserIdToken(_ newUserIdToken: String) {
        self.userIdToken = newUserIdToken
    }
}
