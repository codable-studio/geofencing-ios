//
//  LocationManager.swift
//  Unpause
//
//  Created by Krešimir Baković on 04/03/2020.
//  Copyright © 2020 Krešimir Baković. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject {
    
    static var shared = LocationManager()
    
    let locationManager = CLLocationManager()
    
    let points = [CLLocationCoordinate2D(latitude: 45.7974, longitude: 15.9137),
    CLLocationCoordinate2D(latitude: 45.7970, longitude: 15.9142),
    CLLocationCoordinate2D(latitude: 45.7973, longitude: 15.9146),
    CLLocationCoordinate2D(latitude: 45.7976, longitude: 15.9142),
    CLLocationCoordinate2D(latitude: 45.7981, longitude: 15.9134)]
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func checkIfLocationIsInsidePolygon(location: CLLocationCoordinate2D) -> Bool {
        let polygon = MKPolygon(coordinates: points, count: points.count)
        if polygon.contains(coordinate: location) {
            return true
        } else {
            return false
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if checkIfLocationIsInsidePolygon(location: locations.last!.coordinate) {
            print("💚INSIDE POLYGON💚")
        } else {
            print("💔OUTSIDE POLYGON💔")
        }
        print("🐝🐝🐝🐝\(locations.last!.coordinate)🐝🐝🐝🐝")
    }
}
