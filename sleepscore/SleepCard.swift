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
            
            Color(.systemGray6).cornerRadius(15)
            VStack {
                HStack(alignment: .top) {
                    HStack {
                        Text("LAST NIGHT")
                            .font(.system(size:13))
                        Spacer()
                        Text("+ 105pts").font(.system(size: 12))
                    }
                    Spacer()
                    Image(systemName: sleep.image)
                        .foregroundColor(.green)
                }
                .padding()
                HStack(spacing: 10){
                    HStack(spacing: 0.0){
                        
                        Text(sleep.hours)
                            .font(.system(size: 40).bold())
                        
                        Text("hr").font(.system(size:40))
                    }
                    
                    HStack(spacing: 0.0) {
                        Text(sleep.minutes)
                            .font(.system(size: 40).bold())
                        Text("min").font(.system(size:40))
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
