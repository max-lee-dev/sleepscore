//
//  DataManager.swift
//  sleepscore
//
//  Created by Max  Lee on 12/27/23.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject {
    @Published var users: [User] = []
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("users")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let displayName = data["displayName"] as? String ?? ""
                    let id = data["id"] as? String ?? ""
                    
                    let user = User(id: id, displayName: displayName)
                    self.users.append(user)
                }
            }
            
        }
    }
    func addUser(displayName: String) {
        let db = Firestore.firestore()
        let ref = db.collection("users").document()
        ref.setData(["displayName": displayName, "id": "xd"]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
