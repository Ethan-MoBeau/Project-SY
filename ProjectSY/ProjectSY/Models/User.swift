//
//  User.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/09/01.
//  Copyright © 2020 한상현. All rights reserved.
//

import Foundation
import GoogleSignIn

struct User {
    static var shared = User()
    
    private init() {}
    
    private var userIdToken: String?
    private var connectionToken: String?
    private var userData: [String:Any]?
    
    // MARK: User Data
    mutating func setUserIdToken(_ newUserIdToken: String) {
        self.userIdToken = newUserIdToken
    }
    
    func getUserIdToken() -> String? {
        return self.userIdToken
    }
    
    mutating func setUserData(_ userData: [String:Any]) {
        self.userData = userData
    }
    
    mutating func setSingleUserData(key: String, value: Any){
        guard self.userData == nil else {
            self.userData = [key:value]
            return
        }
        
        self.userData![key] = value
    }
    
    func getUserData() -> [String:Any]? {
        return self.userData
    }
    
    mutating func setConnectionToken(_ newConnectionToken: String) {
        self.connectionToken = newConnectionToken
    }
    
    func getConnectionToken() -> String? {
        return self.connectionToken
    }
    
    // MARK: Sign Out
    private mutating func clean(){
        self.userIdToken = nil
        self.connectionToken = nil
        self.userData = nil
    }
    
    mutating func signOut(){
        self.clean()
        
        GIDSignIn.sharedInstance().signOut()
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys{
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}
