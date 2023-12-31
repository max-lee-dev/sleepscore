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
    @Published var test = true
    @Published var loggedIn = false
    @Published var todaysSleep : Sleep?
    let calendar = Calendar.current
    
    init() {
        
        fetchUsers()
        fetchCurUser()
        getTodaysSleep()
        
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
    
    func getTodaysSleep() {
        let now = Date()
        let userEmail = Auth.auth().currentUser?.email
        guard let yesterday = calendar.date(byAdding: .day, value: -1, to: now) else { return }
        let date = self.formatDateToString(yesterday)
        let fullID = "\(userEmail ?? "")\(date)"
        
        print(fullID)
        
        let db = Firestore.firestore()
        let ref = db.collection("sleeps")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            var sleep = Sleep(id: "", user: "", hours: "", minutes: "", userEmail: "", date: "")
            if let snapshot = snapshot {
                
                for document in snapshot.documents {
                    let data = document.data()
//                    let sleep = Sleep(id: data["id"], user: data["user"], hours: data["hours"], minutes: data["minutes"], userEmail: data["userEmail"], date: data["date"])
                    
                    
                    
                    if (fullID == data["id"] as! String) {
                        
                        
                        
                        let user = data["user"] as? String ?? ""
                        let hours = data["hours"] as? String ?? ""
                        let minutes = data["minutes"] as? String ?? ""
                        let userEmail = data["userEmail"] as? String ?? ""
                        let date = data["date"] as? String ?? ""

                        
                        sleep = Sleep(id: fullID, user: user, hours: hours, minutes: minutes, userEmail: userEmail, date: date)

                        self.todaysSleep = sleep
                        
                        
                        

                    }
                    
                    
                    
                }
                

            }
        }
        

        
    }
    
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d" // Format for "Wednesday, January 1"
        dateFormatter.locale = Locale(identifier: "en_US") // Set locale if needed

        let dateString = dateFormatter.string(from: date)
        
        return dateString
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
