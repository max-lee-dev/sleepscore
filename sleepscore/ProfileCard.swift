//
//  SleepCard.swift
//  sleepscore
//
//  Created by Max  Lee on 12/24/23.
//

import SwiftUI


struct ProfileCard: View {
    @State var user: User?
    @EnvironmentObject var dataManager : DataManager
    
    var body: some View {
        ZStack {
            
            Color(red: 72/255, green: 72/255, blue: 74/255, opacity: 1).cornerRadius(20)
            VStack (spacing: 10) {
               
//                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 1)) {
//                    ForEach(dataManager.lastNightFriends.sorted(by: {$0.value.id < $1.value.id}), id: \.key) {
//                        item in SleepCard(sleep: item.value)
//                    }
//                }
                
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
                            Spacer()
                        }
                        HStack {
                            Text("@maxlee1")
                                .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.75))
                                .font(.system(size: 16))
                            Spacer()
                        }
                        
                    }
                    .padding(.vertical)
                    Spacer()
                    
                }
                .padding(.horizontal)
                
                
                
                Button {
                    dataManager.addFriend(myID: dataManager.currentUser?.id ?? "", username: user!.username)

                } label : {
                    
                    ZStack {
                        
                        ZStack {
                            
                            
                            Color(red: 72/255, green: 72/255, blue: 74/255, opacity: 1)
                            Text("+")
                                .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 1))
                                .font(.system(size: 40))
                                .frame(height: 40)
                                .padding(.horizontal)
                               
                            
                            
                               
                                
                        }
                        .frame(width: 325, height: 40)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(LinearGradient(gradient: Gradient(colors: [Color(red: 213/255, green: 51/255, blue: 105/255), Color(red: 218/255, green: 174/255, blue: 81/255)]), startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                        )
                        .padding(.bottom)
                        
                        
                        
                        
                    }
                    
                }

                    
                    
                                
            }
            Spacer()
            
        }
        .frame(height: 150)
        .padding(.horizontal)
    }
}



#Preview() {
    ProfileCard(user: User(id: "", firstName: "max", lastName: "lee", username: "", email: ""))
        .environmentObject(DataManager())
        
}


