//
//  SleepCard.swift
//  sleepscore
//
//  Created by Max  Lee on 12/24/23.
//

import SwiftUI

struct Sleep {
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let hours: String
    let minutes: String
    let date: String
}


struct SleepCard: View {
    @State var sleep: Sleep
    
    var body: some View {
        ZStack {
            
            Color(red: 102/255, green: 50/255, blue: 236/255, opacity: 1).cornerRadius(15)
            VStack {
                HStack(alignment: .top) {
                    HStack {
                        Text("LAST NIGHT")
                            .font(.system(size:13))
                            .foregroundColor(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.75))
                        Spacer()
                        Text("+ 105pts").font(.system(size: 12))
                            .foregroundColor(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255, opacity: 0.75))
                    }
                    Spacer()
                  
                }
                .padding()
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
                }.padding(.horizontal)
                Spacer()
            }
        }
    }
}

struct SleepCard_Previews: PreviewProvider {
    static var previews: some View {
        SleepCard(sleep: Sleep(id: 0, title: "hi", subtitle: "subtitle", image: "hourglass.bottomhalf.fille", hours: "5", minutes: "23", date: "date"))
    }
}
