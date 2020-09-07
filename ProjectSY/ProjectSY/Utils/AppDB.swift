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
    
    func addData(collection:String, data: [String:Any]){
        var ref: DocumentReference? = nil
        ref = db.collection(collection).addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error)")
            }
            else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func getData(){
        
    }
}
