//
//  Place.swift
//  Geofencing
//
//  Created by Krešimir Baković on 25/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import Foundation
import MapKit

class Place: Equatable {
    static func == (lhs: Place, rhs: Place) -> Bool {
        lhs.name == rhs.name
    }
    
    
    let name: String
    let description: String
    let sightType: String
    let coordinates: [CLLocationCoordinate2D]
    
    init(name: String, description: String, sightType: String, coordinates: [CLLocationCoordinate2D]) {
        self.name = name
        self.description = description
        self.sightType = sightType
        self.coordinates = coordinates
    }
    
    func makePolygonFromCoordinates(coordinates: [CLLocationCoordinate2D]) -> MKPolygon {
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
        return polygon
    }
}
