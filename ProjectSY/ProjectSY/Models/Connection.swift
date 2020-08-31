//
//  Connection.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/08/31.
//  Copyright © 2020 한상현. All rights reserved.
//

import Foundation

struct Connection {
    static var shared = Connection()
    
    private init() {}
    
    private(set) var coupleToken: String?
    
    mutating func setCoupleToken(_ newCoupleToken: String) {
        self.coupleToken = newCoupleToken
    }
}
