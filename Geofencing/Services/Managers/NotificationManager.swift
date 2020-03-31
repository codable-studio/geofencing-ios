//
//  NotificationManager.swift
//  Geofencing
//
//  Created by Krešimir Baković on 30/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation
import MapKit

class NotificationManager: NSObject {
    
    static var shared = NotificationManager()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        setUpNotificationManager()
    }
    
    private func setUpNotificationManager() {
        notificationCenter.delegate = self as? UNUserNotificationCenterDelegate
    }
    
    func sendLocationBasedNotification(locationName: String) {
        let content = UNMutableNotificationContent()
        content.title = "Location alert📌"
        content.body = "You entered \(locationName)."
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: locationName, content: content, trigger: nil)
        NotificationManager.shared.notificationCenter.add(request)
    }
}
