//
//  sleepscoreTabView.swift
//  sleepscore
//
//  Created by Max  Lee on 12/19/23.
//

import SwiftUI

struct sleepscoreTabView: View {
    @StateObject var manager = HealthManager()
    @State var selectedTab = "Home"
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem{
                    Image(systemName: "house")
                }
                .environmentObject(manager)
            ContentView()
                .tag("Content")
                .tabItem{
                    Image(systemName: "person")
                }
            
        }
    }
}

struct sleepscoreTabView_Previews: PreviewProvider {
    static var previews: some View {
        sleepscoreTabView()
    }
}
