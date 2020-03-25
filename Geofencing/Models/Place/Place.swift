//
//  Place.swift
//  Geofencing
//
//  Created by Krešimir Baković on 25/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import Foundation
import MapKit

class Place {
    
    let name: String
    let description: String
    let sightType: String
    let polygonCoordinates: MKPolygon
    
    init(name: String, description: String, sightType: String, polygonCoordinates: MKPolygon) {
        self.name = name
        self.description = description
        self.sightType = sightType
        self.polygonCoordinates = polygonCoordinates
    }
}
