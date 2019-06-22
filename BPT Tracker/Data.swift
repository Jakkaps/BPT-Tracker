//
//  Data.swift
//  BPT Tracker
//
//  Created by Jens Amund on 20/06/2019.
//  Copyright © 2019 Jakkaps. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class Data: BindableObject{
    var didChange = PassthroughSubject<Void, Never>()
    var defaults: UserDefaults = UserDefaults.standard
    
    var allMeasurements: [Measurement]
    
    init() {
        allMeasurements = [Measurement]()
        
        //Retrieving saved measurements if there are any
        if let savedMeasurements = defaults.data(forKey: defaultsKeys.measurements){
            let decoder = JSONDecoder()
            do {
                allMeasurements = try decoder.decode([Measurement].self, from: savedMeasurements)
            } catch {
                print("Failed to load measurements")
            }
        }
    }
    
    func add(measurement: Measurement){
        allMeasurements.append(measurement)
        didChange.send(())
        save()
    }
    
    //Returns a dictionary containing the hour of day as the key and the averaged concentration as the value
    func getAverageMeasurements() -> [Measurement]{
        var averagedMeasurements = [Measurement]()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        
        //Make sure all hours are represented
        for i in 0...23 {
            var hourString = ""
            if i < 10{
                hourString += "0"
            }
            hourString += "\(i)"
            
            averagedMeasurements.append(Measurement(date: formatter.date(from: hourString) ?? Date(), value: 0))
            
            // TODO: Error handling
        }
        
        for measurement in allMeasurements{
            //Little hack to get the hour of the measurement as an int we can use as the index
            let hour = Int(formatter.string(from: measurement.date)) ?? 0
            
            averagedMeasurements[hour].value = Int(((averagedMeasurements[hour].value) + measurement.value)/2)
        }
    
        return averagedMeasurements
    }
    
    func updatePreferences(start: Int, end: Int, frequency: Frequency, until: Date){
        let encoder = JSONEncoder()
        
        if let savedData = try? encoder.encode(start) {
            defaults.set(savedData, forKey: defaultsKeys.startHour)
        } else {
            print("Failed to save")
        }
        
        if let savedData = try? encoder.encode(end) {
            defaults.set(savedData, forKey: defaultsKeys.endHour)
        } else {
            print("Failed to save")
        }
        
        if let savedData = try? encoder.encode(frequency) {
            defaults.set(savedData, forKey: defaultsKeys.freqency)
        } else {
            print("Failed to save")
        }
        
        if let savedData = try? encoder.encode(until) {
            defaults.set(savedData, forKey: defaultsKeys.until)
        } else {
            print("Failed to save")
        }
        
    }
    
    private func save(){
        let encoder = JSONEncoder()
        if let savedData = try? encoder.encode(allMeasurements) {
            defaults.set(savedData, forKey: defaultsKeys.measurements)
        } else {
            print("Failed to save measurements.")
        }
    }
}

struct defaultsKeys {
    static let measurements = "measurements"
    static let startHour = "start_hour"
    static let endHour = "end_hour"
    static let freqency = "frequency"
    static let until = "until"
}
