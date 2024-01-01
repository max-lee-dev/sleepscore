//
//  AddFriendSheet.swift
//  sleepscore
//
//  Created by Max  Lee on 12/31/23.
//

import SwiftUI

struct AddFriendSheet: View {
    @State var searchInput = ""
    @EnvironmentObject var dataManager : DataManager
    var body: some View {
        
            
            ZStack {
                Color(red: 44/255, green: 44/255, blue: 46/255)
                    .ignoresSafeArea()
                VStack(spacing: 15) {
                    HStack {
                        Text("add friends")
                            .font(.system(size: 34))
                            .bold()
                            .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 1))
                        Spacer()
                    }.padding(.top).padding(.horizontal)
                    ZStack {
                        TextField("", text: $searchInput)
                            .placeholder(when: searchInput.isEmpty) {
                                Text("name/username...")
                                    .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.75))
                                    .font(.system(size: 24))
                            }
                            
                            .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 1))
                            .padding()
                            .background(Color( red: 72/255, green: 72/255, blue: 74/255))
                            .cornerRadius(10)
                            .font(.system(size: 24))
                            .onChange(of: searchInput) { value in
                                dataManager.getQueryUsers(query: searchInput)
                            }
                    }.padding(.horizontal)
                    
                    ScrollView {
                        
                        LazyVStack {
                            ForEach(dataManager.queryUsers) {user in
                                ProfileCard(user: user)
                                
                                   
                            }
                            
                        }
                        
                       
                    }
                    
                Spacer()
            }
                
                
        }
        
    }
}








#Preview {
    AddFriendSheet()
        .environmentObject(DataManager())
}
