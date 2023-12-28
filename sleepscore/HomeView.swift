//
//  HomeView.swift
//  sleepscore
//
//  Created by Max  Lee on 12/19/23.
//

import SwiftUI


struct HomeView: View {
    let calendar = Calendar.current
    @State private var displayName = ""
    
    let now = Date()
    @State var time = "hi"
   
    
    
    @EnvironmentObject var manager: HealthManager
    @EnvironmentObject var dataManager: DataManager
    
    
    
    
    
    var body: some View {
        ZStack {
            Spacer()
            Image("sleepscorebackgroundmpb")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 0.0){
            
                
                HStack {
                    Text(manager.formatDateToString(now).lowercased()).fontWeight(.bold).font(.system(size: 27))
                        .foregroundColor(.white)
                        
                    Spacer()
                    Text("🔥 1")
                        .foregroundColor(Color(.orange))
                }.padding().offset(y:10).padding(.top)
                Spacer()
                
                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 1)) {
                        ForEach(manager.sleeps.sorted(by: {$0.value.id < $1.value.id}), id: \.key) {
                            item in SleepCard(sleep: item.value)
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                }
//                NavigationView {
//                    List(dataManager.users, id: \.id) { user in
//                        Text(user.displayName)
//                    }
//                    .navigationTitle("users")
//                    .navigationBarItems(trailing: Button(action: {
//                        dataManager.addUser(displayName: displayName)
//                    }, label: {
//                        Image(systemName: "plus")
//                    }))
//                    
//                    
//                    
//                }
//                TextField("User", text: $displayName)
//                    .foregroundColor(.red)
                
            }.padding(.top)
            
            
                .onAppear {
                    // Call the method to fetch sleep duration when the  view appears
                    if let yesterday = calendar.date(byAdding: .day, value: -1, to: now)  {
                        
                        
                        manager.getSleepDuration(startDate: yesterday, endDate: now) { sleepDuration, error in
                            if let error = error {
                                print("Error fetching sleep duration: \(error.localizedDescription)")
                                return
                            }
                        }
                    }
                }.padding(.top)
            
            
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(DataManager())
            .environmentObject(HealthManager())
    }
}
