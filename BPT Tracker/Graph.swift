//
//  Graph.swift
//  BPT Tracker
//
//  Created by Jens Amund on 19/06/2019.
//  Copyright © 2019 Jakkaps. All rights reserved.
//

import SwiftUI

struct Graph : View {
    let measurements: [Measurement]
    
    var body: some View {
        ScrollView{
            HStack{
                ForEach(measurements){ measurement -> _ModifiedContent<VStack<TupleView<(Spacer, _ModifiedContent<Point, _OffsetEffect>, Text)>>, _PaddingLayout> in
                    let offset = measurement.value * -15
                    return VStack{
                        Spacer()
                        Point()
                            .offset(x: 0, y: CGFloat(offset))
                        Text("\(measurement.value)")
                    }.padding()
                }
            }
                .frame(height: 350)
        }
            .frame(height: 350)
    }
}

struct Point : View {
    var body: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: 10, height: 10)
    }
}

#if DEBUG
struct Graph_Previews : PreviewProvider {
    static var previews: some View {
         let measurements = [Measurement(date: Date(), value: 7), Measurement(date: Date(), value: 10), Measurement(date: Date(), value: 5), Measurement(date: Date(), value: 1), Measurement(date: Date(), value: 4), Measurement(date: Date(), value: 5), Measurement(date: Date(), value: 9), Measurement(date: Date(), value: 2), Measurement(date: Date(), value: 8), Measurement(date: Date(), value: 1), Measurement(date: Date(), value: 7), Measurement(date: Date(), value: 10), Measurement(date: Date(), value: 5), Measurement(date: Date(), value: 1), Measurement(date: Date(), value: 4), Measurement(date: Date(), value: 5), Measurement(date: Date(), value: 9), Measurement(date: Date(), value: 2), Measurement(date: Date(), value: 8), Measurement(date: Date(), value: 1), Measurement(date: Date(), value: 9), Measurement(date: Date(), value: 2), Measurement(date: Date(), value: 8), Measurement(date: Date(), value: 1)]
        
        return Graph(measurements: measurements)
    }
}
#endif
