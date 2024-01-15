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
    @Published var queryUsers: [User] = []
    @Published var thisUserFriendRequests: [String] = []
    let calendar = Calendar.current
    
    init() {
        
        fetchUsers()
        fetchCurUser()
        getTodaysSleep()
    }
    
    func queryUser() {
        
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
                    let friendRequests = data["friendRequests"] as? [String] ?? []
                    let friends = data["friends"] as? [String] ?? []
                    
                    let tempuser = User(id: id, friendRequests: friendRequests, friends: friends, firstName: firstName, lastName: lastName, username: username, email: email)
                    self.users.append(tempuser)
                    self.queryUsers.append(tempuser)
                }
            }
            
        }
    }
    
    func fetchStringUser(username: String) -> User {
        print("seraching")
        for user in users {
            if (username == user.username) {
                print("found: \( user)")
                return user;
            }
        }
        return User(id: "asd", friendRequests: [], firstName: "asd", lastName: "", username: "", email: "");
    }
    
    func addFriendRequest(myID: String, user: User) {
        if (thisUserFriendRequests.contains(user.username) || user.username == currentUser?.username) {
            return
        }
        /// get curr friendrequest list
        let db = Firestore.firestore()
        

        let docRef = db.collection("users").document(user.id)
        var currFriendRequests = [String]()
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    let currFriendRequests = data["friendRequests"] as? [String] ?? []
                }
            }
            
        }
        ///
        
        
        
        
        
        currFriendRequests.append(currentUser?.username ?? "") // do friend request instead
        self.thisUserFriendRequests = currFriendRequests // update



        docRef.updateData(["friendRequests": currFriendRequests]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated!")
            }
        }
    
    }
    
    func AddTwoFriends(user1: User, user2: User) {
        
        let db = Firestore.firestore()
        
        // add user2 to user1's doc

        let docRef = db.collection("users").document(user1.id)
        var currFriends = [String]()
        docRef.getDocument { (document, error) in
           guard error == nil else {
               print("error", error ?? "")
               return
           }

           if let document = document, document.exists {
               let data = document.data()
               if let data = data {
                   print("data", data)
                    currFriends = data["friends"] as? [String] ?? []
               }
           }

        }
        currFriends.append(user2.username)
        docRef.updateData(["friends": currFriends]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated!")
            }
        }
        
        // add user1 to user2's doc
        let docRef2 = db.collection("users").document(user2.id)
        var currFriends2 = [String]()
        docRef2.getDocument { (document, error) in
           guard error == nil else {
               print("error", error ?? "")
               return
           }

           if let document = document, document.exists {
               let data = document.data()
               if let data = data {
                   print("data", data)
                    currFriends2 = data["friends"] as? [String] ?? []
               }
           }

        }
        currFriends2.append(user1.username)     
        docRef2.updateData(["friends": currFriends2]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated!")
            }
        }
        removeFriendRequest(thisUser: user1, otherUser: user2)
    }
    
    func removeFriendRequest(thisUser: User, otherUser: User) {
        let db = Firestore.firestore()
        
        // add user2 to user1's doc
        
        let docRef = db.collection("users").document(thisUser.id)
        guard let index = thisUserFriendRequests.firstIndex(of: otherUser.username) else { return  }
        
        thisUserFriendRequests.remove(at: index)
        docRef.updateData(["friendRequests": thisUserFriendRequests]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated!")
            }
        }
        
    }
    
    
    
    func getQueryUsers(query: String) {
        queryUsers.removeAll()
        for user in users {
            if (user.username.contains(query) || user.firstName.contains(query) || user.lastName.contains(query)) {
                self.queryUsers.append(user)
                print(user)
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
                        let friendRequests = data["friendRequests"] as? [String] ?? []
                        let friends = data["friends"] as? [String] ?? []
                        self.thisUserFriendRequests = friendRequests
                        
                        
                        let user = User(id: id, friendRequests: friendRequests, friends: friends, firstName: firstName, lastName: lastName, username: username, email: email)
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
        ref.setData(["firstName": firstName, "friendRequests": [], "friends": [], "lastName": lastName, "username": username, "email": email, "id": ref.documentID]) { error in
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
        fetchUsers()
        fetchCurUser()
        getTodaysSleep()
    }
    
    
}
