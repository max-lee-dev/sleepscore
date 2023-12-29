//
//  sleepscoreApp.swift
//  sleepscore
//
//  Created by Max  Lee on 12/19/23.
//

import SwiftUI
import Firebase

@main
struct sleepscoreApp: App {
    @State private var userIsLoggedIn = false
    @StateObject var dataManager = DataManager()
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var email = "accounta@gmail.com"
    @State private var password = "123123"
    
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if (dataManager.loggedIn) {
                sleepscoreTabView()
                    .environmentObject(dataManager)
            } else {
                LogIn
            }
        }
    }
    
   
    
    var LogIn: some View {
        ZStack {
            Image("sleepscorebackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
            
            VStack(spacing: 0) {
                Text("welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(y: -100)
                
                TextField("", text: $firstName)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: firstName.isEmpty) {
                        Text("first name")
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                
                
                
                Rectangle()
                    .frame(width:350, height: 1)
                    .foregroundColor(.white)
                    .padding(.bottom)
                Text(dataManager.currentUser?.firstName ?? "dont have")
                
                TextField("", text: $lastName)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: lastName.isEmpty) {
                        Text("last name")
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                
                
                
                Rectangle()
                    .frame(width:350, height: 1)
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                TextField("", text: $username)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: username.isEmpty) {
                        Text("username")
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                
                
                
                Rectangle()
                    .frame(width:350, height: 1)
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                
                
                TextField("", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("email")
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                
                
                
                Rectangle()
                    .frame(width:350, height: 1)
                    .foregroundColor(.white)
                    .padding(.bottom)
                SecureField("", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("password")
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                
                
                Rectangle()
                    .frame(width:350, height: 1)
                    .foregroundColor(.white)
                Button {
                    register()
                    
                } label: {
                    Text("Sign up")
                        .bold()
                        .frame(width: 200, height: 40)
                        .foregroundColor(.white)

                       
                }
                .padding(.top)
                .offset(y: 100)
                Button {
                    login()
                } label: {
                    Text("Already have an account? Log in ")
                        .bold()
                        .frame(width: 300, height: 40)
                        .foregroundColor(.white)

                }
                .padding(.top)
                .offset(y: 110)
                    
                
                
                
            }
            .frame(width: 350)
            .onAppear {
                Auth.auth().addStateDidChangeListener{auth, user in
                    if user != nil {
                        dataManager.logIn()
                    }
                }
            }
            
            

        }
        .ignoresSafeArea()

    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) {
            result, error in if error != nil {
                print (error!.localizedDescription)
            }
        }
    }
    
    func register() {
        
        Auth.auth().createUser(withEmail: email, password: password) {
            result, error in if error != nil {
                print(error!.localizedDescription)
            } else {
                dataManager.addUser(firstName: firstName, lastName: lastName, username: username, email: email)
            }
        }
        
        
        
        
        
    }
    
    
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
