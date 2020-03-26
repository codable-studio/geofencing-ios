//
//  PlaceNetworking.swift
//  Geofencing
//
//  Created by Krešimir Baković on 26/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import Foundation
import RxSwift
import MapKit

class PlaceNetworking: PlaceNetworkingProtocol {
    
    func fetchAllPlacesFromServer() -> Observable<[Place]> {        
        return Observable.empty()
    }
}
