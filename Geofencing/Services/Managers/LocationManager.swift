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
    
    private var lastLocation: CLLocation?
    
    override init() {
        super.init()
        setUpLocationManager()
    }
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
    }
    
    func findCenterOfPlaceAndReturnCircularAreaAroundThatPlace(place: Place) -> CLCircularRegion {
        var sumOfLongitudes = 0.0
        var sumOfLatitudes = 0.0
        for coordinate in place.coordinates {
            sumOfLongitudes += coordinate.longitude
            sumOfLatitudes += coordinate.latitude
        }
        let centerLongitude = sumOfLongitudes / Double(place.coordinates.count)
        let centerLatitude = sumOfLatitudes / Double(place.coordinates.count)
        let centerLocation = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        let regionRadius = findBiggestDistanceFromCenter(center: centerLocation, coordinates: place.coordinates)
        let circularRegion = CLCircularRegion(center: centerLocation, radius: regionRadius, identifier: "\(place.name)")
        return circularRegion
    }
    
    private func findPlaceThatContains(location: CLLocationCoordinate2D) -> Place? {
        var polygonPlace: Place? = nil
        for place in PlaceManager.shared.allPlaces {
            let polygon = place.makePolygonFromCoordinates(coordinates: place.coordinates)
            if polygon.contains(coordinate: location) {
                polygonPlace = place
            }
        }
        return polygonPlace
    }
    
    private func findBiggestDistanceFromCenter(center: CLLocationCoordinate2D, coordinates: [CLLocationCoordinate2D]) -> Double {
        var biggestDistance = 0.0
        for coordinate in coordinates {
            let distance = sqrt(coordinate.longitude * coordinate.longitude + coordinate.latitude * coordinate.latitude)
            if distance > biggestDistance {
                biggestDistance = distance
            }
        }
        return biggestDistance
    }
}


// MARK: - CLLocationManager delegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocationCoordinates = locations.last?.coordinate
             else { return }
        let placeVisited = findPlaceThatContains(location: lastLocationCoordinates)
        if placeVisited != findPlaceThatContains(location: lastLocation?.coordinate ?? CLLocationCoordinate2D()) && findPlaceThatContains(location: lastLocation?.coordinate ?? CLLocationCoordinate2D()) == nil {
            NotificationManager.shared.sendLocationBasedNotification(locationName: placeVisited!.name)
        }
        lastLocation = locations.last
    }
}
