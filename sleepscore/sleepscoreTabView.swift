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
            
        
            
            TabView(selection: $selectedTab) {
                
                
                
                
                HomeView()
                    .tag("Home")
                    .tabItem{
                        Image(systemName: "house")
                    }
                    .environmentObject(manager)
                    
                LogIn()
                    .tag("Log In")
                    .tabItem{
                        Image(systemName: "person")
                    }
                    .environmentObject(dataManager)
                
            }
        }
}

struct sleepscoreTabView_Previews: PreviewProvider {
    static var previews: some View {
        sleepscoreTabView()
            .environmentObject(DataManager())
    }
}
