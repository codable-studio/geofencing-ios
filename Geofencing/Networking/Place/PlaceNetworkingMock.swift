//
//  PlaceNetworkingMock.swift
//  Geofencing
//
//  Created by Krešimir Baković on 25/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import Foundation
import RxSwift
import MapKit

class PlaceNetworkingMock: PlaceNetworkingProtocol {
    
    func fetchAllPlacesFromServer() -> Observable<[Place]> {
        var placeArray = [Place]()
        placeArray.append(PlaceMock.vivas)
        placeArray.append(PlaceMock.zuza)
        placeArray.append(PlaceMock.dubai)
        
        return Observable.just(placeArray)
    }
}


