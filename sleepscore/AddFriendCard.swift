//
//  AddFriendCard.swift
//  sleepscore
//
//  Created by Max  Lee on 12/31/23.
//

import SwiftUI

struct AddFriendCard: View {
    
    @EnvironmentObject var dataManager : DataManager
    var body: some View {
        
        NavigationLink(destination: AddFriendSheet(), label: {
            ZStack {
                //                Color(red: 44/255, green: 44/255, blue: 46/255)
                LinearGradient(gradient: Gradient(colors: [Color(red: 213/255, green: 51/255, blue: 105/255), Color(red: 218/255, green: 174/255, blue: 81/255)]), startPoint: .leading, endPoint: .trailing)
                
                HStack(spacing:0) {
                    
                    Text("add friends")
                        .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.8))
                    
                        .font(.system(size:20))
                        .bold()
                    
                    Text(" to score your sleep with!")
                        .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.8))
                        .font(.system(size:17))
                    
                        
                    
                    
                }
                
                
            }
            .frame(height:45)
            .cornerRadius(15)
            
    })
        
        
    }
}

#Preview {
    AddFriendCard()
        .environmentObject(DataManager())
}
