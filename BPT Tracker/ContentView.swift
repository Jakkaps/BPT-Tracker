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
    
    /*var buttons: [ActionSheet.Button]{
        var btns = [ActionSheet.Button]()
        
        ForEach((0...10)){
            btns.append(.default(Text("Show Sheet"), onTrigger: {
                self.showingSheet = false
        }))
        return btns
    }
    
    var btn: ActionSheet.Button{
        .default(Text("Show Sheet"), onTrigger: {
            self.data.add(measurement: Measurement(date: Date(), value: 1))
            self.showEnergziedSheet = false
        })
    }
    
    var sheet: ActionSheet {
        
        return ActionSheet(title: Text("How energized do you feel?"), message: Text("Select a number from 1-10"), buttons: buttons)
    }*/
    
    @ObjectBinding var data = Data()
    
    var body: some View {
        NavigationView {
            NavigationButton(destination: PreferencesView(data: data)){
                Text("Settings")
            }
            VStack{
                Graph(measurements: measurements)
                List(data.allMeasurements, rowContent: MeasurementRow.init)
            }
                .navigationBarTitle(Text("01/06 - 28/06"))
                .navigationBarItems(trailing: PresentationButton(Text("Add"), destination: EnergyView(data: data)))
        }
    }
}

struct EnergyView: View{
    @State var selected = 5
    var data: Data
    
    var energies: [Int]{
        var e = [Int]()
        for i in 1...10{
            e.append(i)
        }
        
        return e
    }
    var body: some View{
        List(energies) {i in
            
            HStack{
                if self.selected == i{
                    Text("You´re feeling")
                }else{
                    Text("l")
                }
                Spacer()
                Text("\(i)")
                }.tapAction{
                    self.selected = i
            }
            }.onDisappear{
                
                self.data.add(measurement: Measurement(date: Date(), value: self.selected))
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
