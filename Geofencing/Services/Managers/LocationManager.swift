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
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func makeSpecificCircularRegion(latitude: CLLocationDegrees,
                                    longitude: CLLocationDegrees,
                                    radius: CLLocationDistance,
                                    notifyOnEntry: Bool,
                                    notifyOnExit: Bool) -> CLCircularRegion {
        let centerLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = CLCircularRegion(center: centerLocation, radius: radius, identifier: UUID().uuidString)
        region.notifyOnEntry = notifyOnEntry
        region.notifyOnExit = notifyOnExit
        return region
    }
    
    func findCenterOfCoordinatesAndReturnCircularAreaAroundThatCoordinates(coordinates: [CLLocationCoordinate2D]) -> CLCircularRegion {
        var sumOfLongitudes = 0.0
        var sumOfLatitudes = 0.0
        for coordinate in coordinates {
            sumOfLongitudes += coordinate.longitude
            sumOfLatitudes += coordinate.latitude
        }
        let centerLongitude = sumOfLongitudes / Double(coordinates.count)
        let centerLatitude = sumOfLatitudes / Double(coordinates.count)
        let centerLocation = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        let regionRadius = findBiggestDistanceFromLocation(location: centerLocation, locations: coordinates)
        let circularRegion = CLCircularRegion(center: centerLocation, radius: regionRadius, identifier: UUID().uuidString)
        return circularRegion
    }
    
    private func checkIfLocationIsInsideOneOfPolygons(location: CLLocationCoordinate2D) -> Place? {
        var polygonPlace: Place?
        for place in PlaceManager.shared.allPlaces {
            if place.polygon.contains(coordinate: location) {
                polygonPlace = place
            }
        }
        return polygonPlace
    }
    
    private func findBiggestDistanceFromLocation(location: CLLocationCoordinate2D, locations: [CLLocationCoordinate2D]) -> Double {
        var biggestDistance = 0.0
        for location in locations {
            let distance = sqrt(location.longitude * location.longitude + location.latitude * location.latitude)
            if distance > biggestDistance {
                biggestDistance = distance
            }
        }
        return biggestDistance
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocationCoordinates = locations.last?.coordinate else { return }
        guard let placeVisited = checkIfLocationIsInsideOneOfPolygons(location: lastLocationCoordinates) else {
            return
        }
        print("💚💚💚\(placeVisited.name)💚💚💚")
    }
}
