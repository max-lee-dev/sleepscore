//
//  SleepCard.swift
//  sleepscore
//
//  Created by Max  Lee on 12/24/23.
//

import SwiftUI


struct LastNightCard: View {
    
    @EnvironmentObject var dataManager : DataManager
    
    var body: some View {
        ZStack {
            
            Color(red: 44/255, green: 44/255, blue: 46/255, opacity: 1).cornerRadius(20)
            VStack {
                HStack(alignment: .top) {
                    HStack {
                        Text("LAST NIGHT")
                            .font(.system(size:13))
                            .foregroundColor(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.75))
                       
                    }
                    Spacer()
                    
                    
                }
                .padding()
//                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 1)) {
//                    ForEach(dataManager.lastNightFriends.sorted(by: {$0.value.id < $1.value.id}), id: \.key) {
//                        item in SleepCard(sleep: item.value)
//                    }
//                }
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 0) {
                        Text("pfpp  Samyok")
                            .foregroundColor(.white)
                        Text("  +105 pts")
                            .foregroundColor(Color(red: 30/255, green: 151/255, blue: 0))
                            .font(.system(size: 14))
                            
                        Spacer()
                        Text("10")
                            .foregroundColor(.white)
                        Text("hr")
                            .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.75))
                        Text(" 5")
                            .foregroundColor(.white)
                        Text("min")
                            .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.75))
                    }.padding(.horizontal)
                    
                    
                    HStack(spacing: 0) {
                        Text("pfpp  Samyok")
                            .foregroundColor(.white)
                        Text("  +105 pts")
                            .foregroundColor(Color(red: 30/255, green: 151/255, blue: 0))
                            .font(.system(size: 14))
                            
                        Spacer()
                        Text("10")
                            .foregroundColor(.white)
                        Text("hr")
                            .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.75))
                        Text(" 5")
                            .foregroundColor(.white)
                        Text("min")
                            .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.75))
                    }.padding(.horizontal)
                    Spacer()
                }
                
                if (dataManager.currentUserLoading == true) {
                    Text("loading...")
                    
                } else {
//                    Text ("Sadly, you have no friends  \(dataManager.currentUser?.firstName ?? "oh")!")
//                        .foregroundColor(.white)
                
                }
                Spacer()
                
                HStack {
                    Text("VIEW ALL")
                        .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.75))
                        .font(.system(size: 13))
                        .frame(width: 60, height: 30)
                        .padding(.horizontal)
                        .background(Color(red: 72/255, green: 72/255, blue: 74/255, opacity: 1))
                        .cornerRadius(20)
                    Spacer()
                }
                .padding()
                
            }
            
            
            
        }.frame(height: 220)
        
        
    }
    
}



#Preview() {
    LastNightCard()
        .environmentObject(DataManager())
}


