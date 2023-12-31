//
//  SleepCard.swift
//  sleepscore
//
//  Created by Max  Lee on 12/24/23.
//

import SwiftUI


struct SleepCard: View {
    @State var sleep: Sleep // required parameter?
    
    var body: some View {
        ZStack {
            
            Color(red: 102/255, green: 50/255, blue: 236/255, opacity: 1).cornerRadius(20)
            VStack (spacing: 20) {
                HStack(alignment: .top) {
                    HStack {
                        Text("TIME ASLEEP")
                            .font(.system(size:13))
                            .foregroundColor(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.75))
                        Spacer()
                        Text("+ 105pts").font(.system(size: 12))
                            .foregroundColor(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.75))
                    }
                    Spacer()
                  
                }
                .padding(.horizontal).padding(.top)
                HStack(spacing: 10){
                    HStack(spacing: 0.0){
                        
                        Text(sleep.hours)
                            .font(.system(size: 40).bold())
                            .foregroundColor(.white)
                        
                        Text("hr").font(.system(size:40))
                            .foregroundColor(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.75))

                    }
                    
                    HStack(spacing: 0.0) {
                        Text(sleep.minutes)
                            .font(.system(size: 40).bold())
                            .foregroundColor(.white)
                        Text("min").font(.system(size:40))
                            .foregroundColor(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.75))

                    }
                    Spacer()
                    

                    Spacer()
                }.padding(.horizontal)
                ZStack {
                    Color(red: 10/255, green: 8/255, blue: 73/255, opacity: 1)
                    Text("your 4th best out of your past 10 sleeps!")
                        .foregroundColor(.white)
                        .padding()
                        
                }.frame(width: .infinity, height: 50)
                    .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                
               
            }
            
           
        }.frame(maxHeight: 100)
            
       
        
        
       
        
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct SleepCard_Previews: PreviewProvider {
    static var previews: some View {
        SleepCard(sleep: Sleep(id: "id", user: "", hours: "5", minutes: "23", userEmail: "email", date: "saturday, dec 23"))
    }
}
