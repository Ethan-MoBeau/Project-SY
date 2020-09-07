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
    private var userProfileToken: String?
    
    mutating func setUserIdToken(_ newUserIdToken: String) {
        self.userIdToken = newUserIdToken
    }
    
    func getUserIdToken() -> String? {
        return self.userIdToken
    }
    
    mutating func setUserProfileToken(_ newUserProfileToken: String) {
        self.userProfileToken = newUserProfileToken
    }
    
    func getProfileToken() -> String? {
        return self.userProfileToken
    }
    
    mutating func setConnectionToken(_ newConnectionToken: String) {
        self.connectionToken = newConnectionToken
    }
    
    func getConnectionToken() -> String? {
        return self.connectionToken
    }
}
