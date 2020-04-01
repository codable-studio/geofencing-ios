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
    
    private override init() {
        super.init()
        setUpNotificationManager()
        scheduleNotification()
    }
    
    private func setUpNotificationManager() {
        notificationCenter.delegate = self as? UNUserNotificationCenterDelegate
    }
    
    func scheduleNotification() {
        notificationCenter.removeAllPendingNotificationRequests()
        let zuzaCircularArea = LocationManager.shared
            .findCenterOfPlaceAndReturnCircularAreaAroundThatPlace(place: PlaceMock.zuza)
        
        let entranceRequest = makeLocationBasedNotificationRequest(notificationBody: "You are near significant location.",
                                                                   region: zuzaCircularArea,
                                                                   notifyOnEntry: true,
                                                                   notifyOnExit: false)

        notificationCenter.add(entranceRequest)
    }
    
    func makeLocationBasedNotificationRequest(notificationBody: String,
                                              region: CLCircularRegion,
                                              notifyOnEntry: Bool,
                                              notifyOnExit: Bool) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "Location alert📍"
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
