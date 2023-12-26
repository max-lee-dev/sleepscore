//
//  HomeView.swift
//  sleepscore
//
//  Created by Max  Lee on 12/19/23.
//

import SwiftUI

struct HomeView: View {
    let calendar = Calendar.current
    let now = Date()
    @State var time = "hi"
   
    
    
    @EnvironmentObject var manager: HealthManager
    
    
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                Text(manager.formatDateToString(now).lowercased())
                Spacer()
                Text("fire")
            }
            .padding(.horizontal)
            .frame(minWidth: 0, maxHeight: 400, alignment: .topLeading)
            
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                    ForEach(manager.sleeps.sorted(by: {$0.value.id < $1.value.id}), id: \.key) {
                        item in SleepCard(sleep: item.value)
                    }
                }
                .padding(.horizontal)
            }
            
        }
    
        
        .onAppear {
            // Call the method to fetch sleep duration when the view appears
            if let yesterday = calendar.date(byAdding: .day, value: -1, to: now)  {
                
                
                manager.getSleepDuration(startDate: calendar.startOfDay(for: yesterday), endDate: calendar.startOfDay(for: now)) { sleepDuration, error in
                    if let error = error {
                        print("Error fetching sleep duration: \(error.localizedDescription)")
                        return
                    }
                }
            }
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

