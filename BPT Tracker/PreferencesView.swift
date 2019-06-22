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
    @State private var showingDatePickerAlert = false
    
    private var fullDateFormatter: DateFormatter{
        let f = DateFormatter()
        f.dateFormat = "MM-dd-yyy"
        return f
    }
    private var hourFormatter: DateFormatter{
        let f = DateFormatter()
        f.dateFormat = "HH:00"
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
                                Text("\(self.hourFormatter.string(from: self.hourFormatter.date(from: String($0))!) )").tag($0)
                            }
                        }
                    }

                }
                
                HStack{
                    Text("To")
                    Spacer()
                    Picker(selection: $end, label: Text("")) {
                        ForEach(0 ..< 24){
                            Text("\(self.hourFormatter.string(from: self.hourFormatter.date(from: String($0))!) )").tag($0)
                        }
                    }
                }
                
                //DatePicker($until, maximumDate: Date(), displayedComponents: .date)
                DatePicker($until, displayedComponents: .date) {
                    Text("Until")
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
