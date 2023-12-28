//
//  LogIn.swift
//  sleepscore
//
//  Created by Max  Lee on 12/27/23.
//

import SwiftUI
import Firebase
struct LogIn: View {
    var body: some View {
        ZStack {
            VStack {
                Text("hia")
                    .foregroundColor(.black)
                Button {
                    signout()
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
