//
//  Profile.swift
//  sleepscore
//
//  Created by Max  Lee on 12/27/23.
//

import SwiftUI
import Firebase
struct Profile: View {
    @EnvironmentObject var dataManager : DataManager
    @StateObject var newDataManager = DataManager()
    var body: some View {
        ZStack {
            Image("sleepscorebackground")
                .resizable()

                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()

            VStack {
                if (dataManager.loggedIn) {
                    Text("lgged in as \(newDataManager.currentUser?.firstName ?? "nvm")")
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
    Profile()
        .environmentObject(DataManager())
}
