//
//  ContentView.swift
//  BPT Tracker
//
//  Created by Jens Amund on 19/06/2019.
//  Copyright © 2019 Jakkaps. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    let measurements = [Measurement(date: Date(), value: 7), Measurement(date: Date(), value: 10), Measurement(date: Date(), value: 5), Measurement(date: Date(), value: 1), Measurement(date: Date(), value: 4), Measurement(date: Date(), value: 5), Measurement(date: Date(), value: 9), Measurement(date: Date(), value: 2), Measurement(date: Date(), value: 8), Measurement(date: Date(), value: 1), Measurement(date: Date(), value: 7), Measurement(date: Date(), value: 10), Measurement(date: Date(), value: 5), Measurement(date: Date(), value: 1), Measurement(date: Date(), value: 4), Measurement(date: Date(), value: 5), Measurement(date: Date(), value: 9), Measurement(date: Date(), value: 2), Measurement(date: Date(), value: 8), Measurement(date: Date(), value: 1), Measurement(date: Date(), value: 9), Measurement(date: Date(), value: 2), Measurement(date: Date(), value: 8), Measurement(date: Date(), value: 1)]
    
    @State var showEnergziedSheet = false
    var energyLevel = 5
    
    //Buttons from 1-10 for adding your current energy level
    var energyButtons: [ActionSheet.Button]{
        var buttons = [ActionSheet.Button]()
        
        for i in (1...10).reversed(){
            buttons.append(.default(Text("\(i)"), onTrigger: {
                self.showEnergziedSheet = false
                self.data.add(measurement: Measurement(date: Date(), value: i))
            }))
        }
        
        buttons.append(.cancel())
        return buttons
    }
    var sheet: ActionSheet {
        ActionSheet(title: Text("How energized are you?"), message: Text("Select a number from 1-10"), buttons: energyButtons)
    }
    
    @ObjectBinding var data = Data()
    
    var body: some View {
        NavigationView {
            NavigationButton(destination: PreferencesView(data: data)){
                Text("Settings")
            }
            VStack{
                Graph(measurements: measurements)
                List(data.allMeasurements, rowContent: MeasurementRow.init)
                }.navigationBarTitle(Text("01/06 - 28/06"))
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showEnergziedSheet = true
                    }) {
                        Text("Add")
                }
                .presentation(showEnergziedSheet ? sheet : nil)
            )
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
