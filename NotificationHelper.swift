//
//  NotificationHelper.swift
//  BPT Tracker
//
//  Created by Jens Amund on 23/06/2019.
//  Copyright © 2019 Jakkaps. All rights reserved.
//

import Foundation
import UserNotifications
import Combine

class NotificationHelper{
    let center = UNUserNotificationCenter.current()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotifications(_:)), name: .didUpdateNotificationPreferences, object: nil)
        
        registerLocal()
        registerEneryNotificationType()
    }
    
    private func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    @objc func updateNotifications(_ notification: Notification){
        if let data = notification.userInfo as? [String: Any]{
            let start = data["start"] as? Int ?? 0
            let end = data["end"] as? Int ?? 23
            let until = data["until"] as? Date ?? Date()
            let frequency = data["frequency"] as? Frequency ?? .hour
            
            var hoursBetweenNotifications = 1
            switch frequency {
            case .hour:
                hoursBetweenNotifications = 1
            case .twoHours:
                hoursBetweenNotifications = 2
            case .threeHours:
                hoursBetweenNotifications = 3
            case .fourHours:
                hoursBetweenNotifications = 4
            }
            center.removeAllPendingNotificationRequests()
            scheduleNotifications(start: start, end: end, until: until, hoursBetween: hoursBetweenNotifications)
        }
    }
    
    private func scheduleNotifications(start: Int, end: Int, until: Date, hoursBetween: Int){
        let components = DateComponents(hour: 0, minute: 0, second: 0)
        Calendar.current.enumerateDates(startingAfter: Date(), matching: components, matchingPolicy: .nextTime){(date, strict, stop) in
            if let date = date{
                if date < until{
                    for i in stride(from: start, to: end, by: hoursBetween){
                        var sendDate = DateComponents()
                        sendDate.day = Calendar.current.component(.day, from: date)
                        sendDate.month = Calendar.current.component(.month, from: date)
                        sendDate.year = Calendar.current.component(.year, from: date)
                        sendDate.hour = i
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: sendDate, repeats: false)
                        
                        let content = UNMutableNotificationContent()
                        content.title = "Energy Level at \(String(describing: sendDate.hour))"
                        content.body = "How energized are you right now? Select a number from 1-10"
                        content.categoryIdentifier = "ENERGY_LEVEL"
                        content.sound = UNNotificationSound.default
                        
                        let request = UNNotificationRequest(identifier: "non-unique string", content: content, trigger: trigger)
                        center.add(request)
                    }
                }
            }
        }
    }
    
    func testNotification(){
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Energy Level at now"
        content.body = "How energized are you right now? Select a number from 1-10"
        content.categoryIdentifier = "ENERGY_LEVEL"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: "non-unique string", content: content, trigger: trigger)
        center.add(request)
    }
    
    private func registerEneryNotificationType(){
        var actions = [UNNotificationAction]()
        for i in 1...10{
            actions.append(UNNotificationAction(identifier: "ENERGY_LEVEL_\(i)",
                title: "\(i)",
                options: UNNotificationActionOptions(rawValue: 0)))
        }
        
        let energyLevelCategory =
            UNNotificationCategory(identifier: "ENERGY_LEVEL",
                                   actions: actions,
                                   intentIdentifiers: [],
                                   hiddenPreviewsBodyPlaceholder: "",
                                   options: .hiddenPreviewsShowTitle)
        
        center.setNotificationCategories([energyLevelCategory])
    }
}

extension Notification.Name {
    static let didUpdateNotificationPreferences = Notification.Name("didUpdateNotificationPreferences")
}
