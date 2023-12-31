//
//  sleepscoreTabView.swift
//  sleepscore
//
//  Created by Max  Lee on 12/19/23.
//

import SwiftUI

struct sleepscoreTabView: View {
    @StateObject var manager = HealthManager()
    @EnvironmentObject var dataManager : DataManager
    @State var selectedTab = "Home"
    var body: some View {
            
        
            
                
                
                
                
                HomeView()
                    .tag("Home")
                    .tabItem{
                        Image(systemName: "house")
                    }
                    .environmentObject(manager)
                    .environmentObject(dataManager)
                    
               
                
            
        }
}

struct sleepscoreTabView_Previews: PreviewProvider {
    static var previews: some View {
        sleepscoreTabView()
            .environmentObject(DataManager())
    }
}
