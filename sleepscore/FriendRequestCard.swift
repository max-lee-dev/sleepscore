//
//  SleepCard.swift
//  sleepscore
//
//  Created by Max  Lee on 12/24/23.
//

import SwiftUI


struct FriendRequestCard: View {
    @State var user: User?
    
    @EnvironmentObject var dataManager : DataManager
    
    
  
    
    var body: some View {
        
        ZStack {
            
            Color(red: 72/255, green: 72/255, blue: 74/255, opacity: 1).cornerRadius(10)
            VStack (spacing: 10) {
               
//                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 1)) {
//                    ForEach(dataManager.lastNightFriends.sorted(by: {$0.value.id < $1.value.id}), id: \.key) {
//                        item in SleepCard(sleep: item.value)
//                    }
//                }
                HStack {
                    HStack(spacing: 20) {
                        ZStack {
                            Ellipse()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color(.white))
                        }
                        VStack {
                            HStack {
                                Text("\(user!.firstName) \(user!.lastName)")
                                    .foregroundColor(.white)
                                    .font(.system(size:30))
                                    .bold()
                                    .frame(alignment: .leading)
                                    
                                Spacer()
                                
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("@\(user!.username)")
                                    .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.75))
                                    .font(.system(size: 16))
                                Spacer()
                            }
                            
                            
                        }
                        .padding(.vertical)
                        Spacer()
                        
                    }
                    .frame(width: 250)
                    .padding(.horizontal)
                    
                    
                    
                    HStack (spacing: 0) {
                        
                        Button {
                            dataManager.AddTwoFriends(user1: dataManager.currentUser ?? User(id: "", firstName: "", lastName: "", username: "", email: ""), user2: user ?? User(id: "", firstName: "", lastName: "", username: "", email: ""))
                            
                            
                        } label : {
                            Label("", systemImage: "checkmark")
                                .foregroundColor(Color(red: 152/255, green: 196/255, blue: 162/255))
                                .font(.system(size:32))
                           
                            
                        }
                        Button {
                            dataManager.removeFriendRequest(thisUser: dataManager.currentUser ?? User(id: "", firstName: "", lastName: "", username: "", email: ""), otherUser: user ?? User(id: "", firstName: "", lastName: "", username: "", email: ""))
                            
                        } label: {
                            Label("", systemImage: "xmark")
                                .foregroundColor(Color(red: 247/255, green: 89/255, blue: 89/255))
                                .font(.system(size:30))
                        }
                    }
                    .padding(.trailing)
                    
                }
                
               
                

                    
                    
                                
            }
            Spacer()
            
        }
        .frame(height: 0)
        
    }
}



#Preview() {
    FriendRequestCard(user: User(id: "SSOVFbxRyAoGJSKpK8tE", firstName: "1", lastName: "1", username: "1", email: "1@gmail.com"))
        .environmentObject(DataManager())
        
}


