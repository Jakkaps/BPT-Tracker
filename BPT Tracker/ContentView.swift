//
//  ContentView.swift
//  BPT Tracker
//
//  Created by Jens Amund on 19/06/2019.
//  Copyright © 2019 Jakkaps. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    let measurements = [Measurement(date: Date(), value: 7), Measurement(date: Date(), value: 7), Measurement(date: Date(), value: 7)]
    
    var body: some View {
        NavigationView {
            VStack{
                Rectangle()
                List(measurements, rowContent: MeasurementRow.init)
            }
                .navigationBarTitle(Text("01/06 - 28/06"))
                .navigationBarItems(leading:
                    Button(action: { print("Settings tapped")
                    }) { Text("Settings")
                })
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
