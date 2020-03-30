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

class NotificationManager: NSObject {
    
    static var shared = NotificationManager()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        notificationCenter.delegate = self
        scheduleNotification()
    }
    
    func scheduleNotification() {
        notificationCenter.removeAllPendingNotificationRequests()
        let circularArea = LocationManager.shared
            .findCenterOfCoordinatesAndReturnCircularAreaAroundThatCoordinates(coordinates: PlaceMock.zuzaCoordinates)
        print("😡😡😡😡😡😡CENTER:\(circularArea.center)😡😡😡😡😡😡")
        print("😡😡😡😡😡😡RADIUS:\(circularArea.radius)😡😡😡😡😡😡")
        
        let entranceRequest = makeLocationBasedNotificationRequest(notificationBody: "You entered area",
                                                                   region: circularArea,
                                                                   notifyOnEntry: true,
                                                                   notifyOnExit: false)
        let exitRequest = makeLocationBasedNotificationRequest(notificationBody: "You left area.",
                                                               region: circularArea,
                                                               notifyOnEntry: false,
                                                               notifyOnExit: true)

        notificationCenter.add(entranceRequest, withCompletionHandler: nil)
        notificationCenter.add(exitRequest, withCompletionHandler: nil)
    }
    
    func makeLocationBasedNotificationRequest(notificationBody: String,
                                              region: CLCircularRegion,
                                              notifyOnEntry: Bool,
                                              notifyOnExit: Bool) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "Entered📍"
        content.body = notificationBody
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        region.notifyOnEntry = notifyOnEntry
        region.notifyOnExit = notifyOnExit
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        return request
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶")
        completionHandler([.alert, .sound])
    }
}
