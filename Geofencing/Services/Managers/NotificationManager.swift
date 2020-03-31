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
        scheduleNotification()
    }
    
    private func setUpNotificationManager() {
        notificationCenter.delegate = self as? UNUserNotificationCenterDelegate
    }
    
    func scheduleNotification() {
        notificationCenter.removeAllPendingNotificationRequests()
        let zuzaCircularArea = LocationManager.shared
            .findCenterOfPlaceAndReturnCircularAreaAroundThatPlace(place: PlaceMock.zuza)
        
        let entranceRequest = makeLocationBasedNotificationRequest(notificationBody: "",
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
        content.body = "You entered \(region.identifier)"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        region.notifyOnEntry = notifyOnEntry
        region.notifyOnExit = notifyOnExit
        
        LocationManager.shared.locationManager.startMonitoring(for: region)
    
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        let request = UNNotificationRequest(identifier: "\(region.identifier)", content: content, trigger: trigger)
        return request
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
