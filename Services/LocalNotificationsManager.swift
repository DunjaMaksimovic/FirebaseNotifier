//
//  LocalNotificationsManager.swift
//  FirebaseNotifier
//
//  Created by Dunja Maksimovic on 8/12/20.
//  Copyright © 2020 Dunja Maksimovic. All rights reserved.
//

import Foundation
import UserNotifications

final class LocalNotificationsManager {
	
	static let defaultMessage = "Have a nice day!"
	
	// MARK: - Schedule
	
    static func scheduleNotification(date: Date, message: String?, identifier: String?) {
		
		// Request
		let request = UNNotificationRequest(identifier: identifier ?? UUID().uuidString, content: getContent(message: message), trigger: getTrigger(for: date))
		
		// Add
		UNUserNotificationCenter.current().add(request) { _ in }
	}
	
	// MARK: - Content & trigger
	
	private static func getContent(message: String?) -> UNMutableNotificationContent {
		
		let content = UNMutableNotificationContent()
		content.title = "Alarm"
		content.body = message ?? defaultMessage
		content.sound = UNNotificationSound.default
		
		return content
	}
	
	private static func getTrigger(for date: Date) -> UNNotificationTrigger {
		
		let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
		let triggerForDate = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
		
		return triggerForDate
	}
}
