//
//  dbController.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/09/06.
//  Copyright © 2020 한상현. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct AppDB {
    static let shared = AppDB()
    
    let db = Firestore.firestore()
    
    func addData(collection:String, id: String, data: [String:Any]) {
        db.collection(collection).document(id).setData(data, completion: { error in
            if let error = error {
                print("Error adding document: \(error)")
            }
            else {
                print("\(collection) \(id) : Document added Succesfully")
            }
        })
    }
    
    func addSingleData(collection:String, id: String, data: [String:Any]) {
        db.collection(collection).document(id).setData(data, merge: true) { error in
            if let error = error {
                print("Error adding document: \(error)")
            }
            else {
                print("\(collection) \(id) : Document added Succesfully")
            }
        }
    }
    
    // MARK: completion handler를 사용해야 하기 때문에 각 VC에서 호출
    // func getData((collection:String, id: String)
    
    func removeData(collection:String, id: String) {
        db.collection(collection).document(id).delete { error in
            if let error = error {
                print("Error Deleting document: \(error)")
            }
            else {
                print("Document Deleted Succesfully")
            }
        }
    }
}
