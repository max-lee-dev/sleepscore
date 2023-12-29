//
//  LogIn.swift
//  sleepscore
//
//  Created by Max  Lee on 12/27/23.
//

import SwiftUI
import Firebase
struct LogIn: View {
    @EnvironmentObject var dataManager : DataManager
    var body: some View {
        ZStack {
            VStack {
                if (dataManager.loggedIn) {
                    Text("lgged in")
                        .foregroundColor(.gray)
                } else {
                    Text("nah")
                        .foregroundColor(.gray)
                }
                Button {
                    dataManager.logOut()
                } label: {
                    Text("signout")
                }
            }
            
        }
    }
    
    func signout() {
        try! Auth.auth().signOut()
    }
    
   
}

#Preview {
    LogIn()
}
