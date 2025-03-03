//
//  TaskReminderNotifications.swift
//  ToDoList
//
//  Created by Sonali Kalange on 27/02/25.
//

import Foundation
import UserNotifications

class TaskReminderNotifications {
    public lazy var shared = TaskReminderNotifications()
    
    func scheduleReminderNotification(at time: Date, taskDescription: String) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { allowed, error in
            if allowed {
                debugPrint("Notifications allowed")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = taskDescription
        content.sound = UNNotificationSound.default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Notification scheduled")
            }
        }
    }
}
