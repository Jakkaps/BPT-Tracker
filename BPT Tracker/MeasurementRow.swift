//
//  Measurement.swift
//  BPT Tracker
//
//  Created by Jens Amund on 19/06/2019.
//  Copyright © 2019 Jakkaps. All rights reserved.
//

import SwiftUI

struct MeasurementRow : View {
    var measurement: Measurement
    var formatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        return dateFormatter
    }
    
    var body: some View {
        HStack{
            Text("\(measurement.value)")
            Spacer()
            Text("\(formatter.string(from: measurement.date))")
        }.padding()
    }
}

#if DEBUG
struct Measurement_Previews : PreviewProvider {
    static var previews: some View {
        MeasurementRow(measurement: Measurement(date: Date(), value: 7))
    }
}
#endif
