//
//  PreferencesView.swift
//  BPT Tracker
//
//  Created by Jens Amund on 19/06/2019.
//  Copyright © 2019 Jakkaps. All rights reserved.
//

import SwiftUI

struct PreferencesView : View {
    var data: Data
    
    @State private var frequencySelected = 0
    @State private var start = 0
    @State private var end = 23
    @State private var until = Date()
    
    private var formatter: DateFormatter{
        let f = DateFormatter()
        f.dateFormat = "MM-dd-yyy"
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
                    HStack{
                        Text("From")
                        Spacer()
                        Picker(selection: $start, label: Text("")) {
                            ForEach(0 ..< 24){
                                Text("\($0):00").tag($0)
                            }
                        }
                    }

                }
                
                HStack{
                    Text("To")
                    Spacer()
                    Picker(selection: $end, label: Text("")) {
                        ForEach(0 ..< 24){
                            Text("\($0):00").tag($0)
                        }
                    }
                }
                HStack{
                    Text("Until")
                    Spacer()
                    Text("\(until, formatter: formatter)")
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
            
        }
        .listStyle(.grouped)
        .onDisappear{
            self.data.updatePreferences(start: self.start, end: self.end, frequency: Frequency.allCases[self.frequencySelected], until: self.until)
        }
    }
}

enum Frequency: String, CaseIterable, Codable{
    case hour = "hour"
    case twoHours = "two hours"
    case threeHours = "three hours"
    case fourHours = "four hours"
}

#if DEBUG
struct PreferencesView_Previews : PreviewProvider {
    static var previews: some View {
        PreferencesView(data: Data())
    }
}
#endif
