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
    let duration: String
    let date: String
}


struct SleepCard: View {
    @State var sleep: Sleep
    
    var body: some View {
        ZStack {
            
            Color(.systemGray6).cornerRadius(15)
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("last night")
                        Text(sleep.date)
                            .font(.caption)
                    }
                    Spacer()
                    Image(systemName: sleep.image)
                        .foregroundColor(.green)
                }
                .padding()
                
                Text(sleep.duration)
                    .font(.system(size: 24))
                    .padding()
            }
        }
    }
}

struct SleepCard_Previews: PreviewProvider {
    static var previews: some View {
        SleepCard(sleep: Sleep(id: 0, title: "hi", subtitle: "subtitle", image: "hourglass.bottomhalf.filled", duration: "73hr 20m", date: "date"))
    }
}
