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
    
    let width: CGFloat = 1000.0
    var formatter: DateFormatter{
        let f = DateFormatter()
        f.dateFormat = "hh"
        return f
    }
    
    var body: some View {
        GeometryReader{ size in
            ScrollView {
                VStack(alignment: .leading){
                    GeometryReader{ geometry in
                        Path{ path in
                            path.move(to: CGPoint(
                                x: 0.0,
                                y: CGFloat(self.measurements[0].value) * (geometry.size.height / 20)
                                )
                            )
                            
                            
                            for i in 0 ..< self.measurements.count {
                                path.addLine(to: CGPoint(
                                    x: CGFloat(i)*(geometry.size.width/24),
                                    y: CGFloat(self.measurements[i].value) * (geometry.size.height / 20)
                                    )
                                )
                            }
                            }
                            .strokedPath(StrokeStyle(lineWidth: 1))
                        
                        }.frame(width: self.width, height: 100)
                    
                    Spacer()
                    
                    ZStack{
                        ForEach((0 ..< self.measurements.count)){i in
                            Text("\(self.measurements[i].date, formatter: self.formatter)")
                                .offset(x: (self.width/24)*CGFloat(i), y: 0)
                        }
                    }
                    }
                    .padding()
                    .frame(height: size.size.height)
            }
        }
        
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
