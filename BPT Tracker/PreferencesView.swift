//
//  PreferencesView.swift
//  BPT Tracker
//
//  Created by Jens Amund on 19/06/2019.
//  Copyright © 2019 Jakkaps. All rights reserved.
//

import SwiftUI

struct PreferencesView : View {
    @State private var frequencySelected = 0
    @State private var start = Date()
    @State private var end = Date()
    @State private var until = Date()
    
    var formatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "HH"
        return f
    }
    
    var body: some View {
        List{
            Section(header: Text("Tracking")) {
                HStack{
                    Text("Ask every")
                    Spacer()
                    Picker(selection: $frequencySelected, label: Text("")) {
                            ForEach(0 ..< Frequency.allCases.count){
                                Text("\(Frequency.allCases[$0].rawValue)").tag($0)
                            }
                        }
                }
                VStack{
                    HStack{€
                        Text("From")
                        Spacer()
                        Text("\(start, formatter: formatter)")
                    }

                }
                
                HStack{
                    Text("To")
                    Spacer()
                    DatePicker($end,
                               displayedComponents: .hourAndMinute)
                }
                HStack{
                    Text("Until")
                    DatePicker($until,
                               displayedComponents: .date)
                }
            }
            
            Section(header: Text("Support"), footer: Text( "Admittedly this app wasn't too time-consuming to make. As a college student though, every penny counts").lineLimit(3)){
                HStack{
                    Spacer()
                    Button(action: {
                        print("Hei")
                    }, label: {
                        Text("Donate")
                            .font(.largeTitle)
                            .color(.green)
                    })
                    Spacer()
                }
            }
            
        }.listStyle(.grouped)
    }
}

enum Frequency: String, CaseIterable{
    case quarter = "15 minutes"
    case halfHour = "30 minutes"
    case hour = "hour"
    case twoHours = "two hours"
    case threeHours = "three hours"
    case fourHours = "four hours"
}

#if DEBUG
struct PreferencesView_Previews : PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
#endif
