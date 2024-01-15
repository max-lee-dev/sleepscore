//
//  AddFriendSheet.swift
//  sleepscore
//
//  Created by Max  Lee on 12/31/23.
//

import SwiftUI

struct AddFriendSheet: View {
    @State var searchInput = ""
    @State private var showPopup = false
    @EnvironmentObject var dataManager : DataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Label("", systemImage: "arrowshape.backward.fill")
                    .foregroundColor(Color( red: 72/255, green: 72/255, blue: 74/255))
            }
        }
    }
    
    
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
                        Button {
                            showPopup.toggle()
                        } label: {
                            ZStack {
                            
                            
                                
                                Label("0", systemImage: "person.fill")
                                    .font(.system(size: 24))
                            }
                            .foregroundColor(.white)
                            .frame(width: 70, height: 35)
                            .cornerRadius(10)
                        }
                        .background(Color( red: 72/255, green: 72/255, blue: 74/255))
                        .frame(width: 70, height: 35)
                        .cornerRadius(10)
                        .foregroundColor(Color( red: 72/255, green: 72/255, blue: 74/255))
                    }.padding(.top).padding(.horizontal)
                    ZStack {
                       
                        Rectangle()
                        .frame(height: 45)
                        .foregroundColor(Color( red: 72/255, green: 72/255, blue: 74/255))
                        .cornerRadius(10)
                        TextField("", text: $searchInput)
                            .placeholder(when: searchInput.isEmpty) {
                                Text("name/username...")
                                    .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.75))
                                    .font(.system(size: 24))
                            }
                            
                            .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 1))
                            .padding(.horizontal)
                            .background(Color( red: 72/255, green: 72/255, blue: 74/255))
                            .cornerRadius(10)
                            .font(.system(size: 24))
                            .onChange(of: searchInput) { value in
                                dataManager.getQueryUsers(query: searchInput)
                            }
                        
                    }.padding(.horizontal)
                    
                    ScrollView {
                        
                        LazyVStack(spacing: 20) {
                            ForEach(dataManager.queryUsers) {user in
                                ProfileCard(user: user)
                                
                                   
                            }
                            
                        }
                        
                       
                    }
                    
                Spacer()
            }
                
                
            }.sheet(isPresented: $showPopup) {
                FriendRequestsSheet()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
        
    }
}








#Preview {
    AddFriendSheet()
        .environmentObject(DataManager())
}
