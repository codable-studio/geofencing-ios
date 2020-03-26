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
    
    //let allPlaces = PlaceManager.shared.allPlaces
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
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
