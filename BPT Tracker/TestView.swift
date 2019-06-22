//
//  TestView.swift
//  BPT Tracker
//
//  Created by Jens Amund on 22/06/2019.
//  Copyright © 2019 Jakkaps. All rights reserved.
//

import SwiftUI

struct TestView : View {
    let width: CGFloat = 1000.0
    
    let measurements = [Measurement(date: Date(), value: 7), Measurement(date: Date(), value: 10), Measurement(date: Date(), value: 5), Measurement(date: Date(), value: 1), Measurement(date: Date(), value: 4), Measurement(date: Date(), value: 5), Measurement(date: Date(), value: 9), Measurement(date: Date(), value: 2), Measurement(date: Date(), value: 8), Measurement(date: Date(), value: 1), Measurement(date: Date(), value: 7), Measurement(date: Date(), value: 10), Measurement(date: Date(), value: 5), Measurement(date: Date(), value: 1), Measurement(date: Date(), value: 4), Measurement(date: Date(), value: 5), Measurement(date: Date(), value: 9), Measurement(date: Date(), value: 2), Measurement(date: Date(), value: 8), Measurement(date: Date(), value: 1), Measurement(date: Date(), value: 9), Measurement(date: Date(), value: 2), Measurement(date: Date(), value: 8), Measurement(date: Date(), value: 1)]
    
    var body: some View {
        ScrollView{
            ZStack{
                ForEach((0 ..< 24)){i in
                    Text("\(i)")
                        .offset(x: (self.width/24)*CGFloat(i), y: 0.0)
                }
            }
        }
    }
}

#if DEBUG
struct TestView_Previews : PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
#endif
