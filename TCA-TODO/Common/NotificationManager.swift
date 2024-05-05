//
//  NotificationManager.swift
//  TCA-TODO
//
//  Created by t.nakajima on 2024/05/05.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if success {
                debugPrint("Authorization granted.")
            } else if let error = error {
                debugPrint("Authorization error: \(error.localizedDescription)")
            }
        }
    }

    func scheduleNotification(date: Date, alertText: String) {
        let content = UNMutableNotificationContent()
        content.title = "リマインド"
        content.body = alertText
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                debugPrint("Error scheduling notification: \(error.localizedDescription)")
            } else {
                debugPrint("Notification scheduled.")
            }
        }
    }
}
