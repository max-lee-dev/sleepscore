//
//  SleepCard.swift
//  sleepscore
//
//  Created by Max  Lee on 12/24/23.
//

import SwiftUI


struct LeaderboardCard: View {
    
    @EnvironmentObject var dataManager : DataManager
    
    var body: some View {
        ZStack {
            
            Color(red: 44/255, green: 44/255, blue: 46/255, opacity: 1).cornerRadius(20)
            VStack (spacing: 20) {
                HStack(alignment: .top) {
                    HStack {
                        Text("LEADERBOARD")
                            .font(.system(size:13))
                            .foregroundColor(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.75))
                       
                    }
                    Spacer()
                    
                    
                }
                .padding(.horizontal).padding(.top)
//                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 1)) {
//                    ForEach(dataManager.lastNightFriends.sorted(by: {$0.value.id < $1.value.id}), id: \.key) {
//                        item in SleepCard(sleep: item.value)
//                    }
//                }
                
                if (dataManager.currentUserLoading == true) {
                    Text("loading...")
                    
                } else {
                    Text ("Sadly, you have no friends  \(dataManager.currentUser?.firstName ?? "oh")!")
                        .foregroundColor(.white)
                
                }
                Spacer()
                
                HStack {
                    Text("VIEW ALL")
                        .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.75))
                        .font(.system(size: 10))
                        .frame(width: 60, height: 20)
                        .padding(.horizontal)
                        .background(Color(red: 72/255, green: 72/255, blue: 74/255, opacity: 1))
                        .cornerRadius(20)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom)
                
            }
            Spacer()
            
        }
        .frame(maxHeight: 75)
    }
}



#Preview() {
    LeaderboardCard()
        .environmentObject(DataManager())
}


