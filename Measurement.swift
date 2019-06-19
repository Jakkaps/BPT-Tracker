//
//  Measurement.swift
//  BPT Tracker
//
//  Created by Jens Amund on 19/06/2019.
//  Copyright © 2019 Jakkaps. All rights reserved.
//

import Foundation
import SwiftUI

struct Measurement: Identifiable {
    var date: Date
    let id = UUID()
    var value: Int
}
