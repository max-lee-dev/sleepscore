//
//  HomeView.swift
//  sleepscore
//
//  Created by Max  Lee on 12/19/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var manager: HealthManager
    
    
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                SleepCard(sleep: Sleep(id: 0, title: "hi", subtitle: "subtitle", image: "hourglass.bottomhalf.filled", duration: "73hr 20m"))
                SleepCard(sleep: Sleep(id: 0, title: "hi", subtitle: "subtitle", image: "hourglass.bottomhalf.filled", duration: "73hr 20m"))
            }
            .padding(.horizontal)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

