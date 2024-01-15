//
//  FriendRequestsSheet.swift
//  sleepscore
//
//  Created by Max  Lee on 1/13/24.
//

import SwiftUI

struct FriendRequestsSheet: View {
    @EnvironmentObject var dataManager : DataManager
    var body: some View {
        ZStack {
            Color(red: 44/255, green: 44/255, blue: 46/255)
                .ignoresSafeArea()
            VStack {
                
                HStack {
                    Text("friend requests")
                        .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.75))
                        .font(.system(size: 24))
                    Spacer()
                }
                ScrollView {
                    VStack(spacing: 100) {
                        
                        ForEach(dataManager.thisUserFriendRequests, id: \.self) {user in
                            FriendRequestCard(user: dataManager.fetchStringUser(username: user))
                            
                            
                        }
                        
                    }.padding(.top)
                        .padding(.top)
                        .padding(.top)
                      
                   
                }
                
                Spacer()
            }
            .padding()
            Spacer()
            
        }
        .onAppear() {
            dataManager.fetchCurUser()
        }
        .presentationDetents([.height(500), .fraction(1)])
    }
}

#Preview {
    FriendRequestsSheet()
        .environmentObject(DataManager())
}
