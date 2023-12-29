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
    @Published var currentUser : User?
    @Published var currentUserLoading = true
    @Published var loggedIn = false
    
    init() {
        
        fetchUsers()
        fetchCurUser()
        
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
                    
                    
                    let firstName = data["firstName"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let id = data["id"] as? String ?? ""
                    
                    let tempuser = User(id: id, firstName: firstName, lastName: lastName, username: username, email: email)
                    self.users.append(tempuser)
                }
            }
            
        }
    }
    
    func fetchCurUser() {
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
                    if (Auth.auth().currentUser?.email == data["email"] as? String) {
                        
                        let firstName = data["firstName"] as? String ?? ""
                        let lastName = data["lastName"] as? String ?? ""
                        let username = data["username"] as? String ?? ""
                        let email = data["email"] as? String ?? ""
                        let id = data["id"] as? String ?? ""
                        
                        
                        let user = User(id: id, firstName: firstName, lastName: lastName, username: username, email: email)
                        self.currentUser = user
                    }

                }
            }
            self.currentUserLoading = false

        }
    }
    
    func addUser(firstName: String, lastName: String, username: String, email: String) {
        let db = Firestore.firestore()
        let ref = db.collection("users").document()
        ref.setData(["firstName": firstName, "lastName": lastName, "username": username, "email": email, "id": ref.documentID]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func logOut() {
        self.loggedIn = false
        self.currentUser = nil
        try! Auth.auth().signOut()
        
    }
    
    func logIn() {
        self.loggedIn = true
    }
}
