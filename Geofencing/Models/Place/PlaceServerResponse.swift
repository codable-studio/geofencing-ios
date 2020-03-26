//
//  PlaceFetchingResponse.swift
//  Geofencing
//
//  Created by Krešimir Baković on 25/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import Foundation

enum PlaceFetchingResponse {
    case success(Place)
    case error(GeofencingError)
}
