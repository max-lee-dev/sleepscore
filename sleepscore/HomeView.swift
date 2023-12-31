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
    @EnvironmentObject var dataManager : DataManager // Have my own dataManager that will have updated data! Not sure if this is good solution but it'll do
    
    
    init() {
//        dataManager.addSleep()
    }
    
    
    var body: some View {
        ZStack {
            Spacer()
            Image("sleepscorehomebackground")
                .resizable()
//                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 0){
            
                
                HStack {
                    Text(manager.formatDateToString(now).lowercased()).fontWeight(.bold).font(.system(size: 27))
                        .foregroundColor(.white)
                        
                        
                    Spacer()
                    HStack(spacing: 0) {
                        Text("🔥5")
                            .foregroundColor(.orange)
                            .font(.title2)
                            .bold()
                            .frame(width: 60, height: 30)
                    }.background(Color(red: 65/255, green: 36/255, blue: 138/255, opacity: 1))
                        .cornerRadius(10)

                        
                }.padding()
                
                VStack(spacing: 35) {
                    ZStack {
                        if (dataManager.currentUserLoading == true) {
                            SleepCard(sleep: Sleep(id: "", user: "", hours: "...", minutes: "...", userEmail: "", date: ""))
                            
                        } else {
                            SleepCard(sleep: dataManager.todaysSleep ?? Sleep(id: "", user: "", hours: "", minutes: "3", userEmail: "", date: ""))
                        
                        }
                       
                      
                    }.padding()
                    LastNightCard()
                        .padding(.horizontal)
                    
                    
                    LeaderboardCard()
                        .padding(.horizontal)
                    
                }.padding(.top)
                          
               
                Spacer()
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
                
            }
            
            
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
                }
            Spacer()
            
            
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HealthManager())
            .environmentObject(DataManager())
    }
}
