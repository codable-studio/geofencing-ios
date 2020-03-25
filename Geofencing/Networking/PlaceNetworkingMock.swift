//
//  PlaceNetworking.swift
//  Geofencing
//
//  Created by Krešimir Baković on 25/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import Foundation
import MapKit

class PlaceNetworkingMock {
    let zgradeKvart = [CLLocationCoordinate2D(latitude: 45.7974, longitude: 15.9137),
                       CLLocationCoordinate2D(latitude: 45.7970, longitude: 15.9142),
                       CLLocationCoordinate2D(latitude: 45.7973, longitude: 15.9146),
                       CLLocationCoordinate2D(latitude: 45.7976, longitude: 15.9142),
                       CLLocationCoordinate2D(latitude: 45.7981, longitude: 15.9134)]
    
    let vivas = [CLLocationCoordinate2D(latitude: 45.7976, longitude: 15.9138),
                 CLLocationCoordinate2D(latitude: 45.7978, longitude: 15.9139),
                 CLLocationCoordinate2D(latitude: 45.7978, longitude: 15.9138),
                 CLLocationCoordinate2D(latitude: 45.7977, longitude: 15.9137)]
    
    let zuza = [CLLocationCoordinate2D(latitude: 45.7971, longitude: 15.9133),
                CLLocationCoordinate2D(latitude: 45.7969, longitude: 15.9135),
                CLLocationCoordinate2D(latitude: 45.7967, longitude: 15.9137),
                CLLocationCoordinate2D(latitude: 45.7967, longitude: 15.9138),
                CLLocationCoordinate2D(latitude: 45.7971, longitude: 15.9136),
                CLLocationCoordinate2D(latitude: 45.7972, longitude: 15.9134)]
    
    let dubai = [CLLocationCoordinate2D(latitude: 45.7975, longitude: 15.9124),
                 CLLocationCoordinate2D(latitude: 45.7974, longitude: 15.9123),
                 CLLocationCoordinate2D(latitude: 45.7976, longitude: 15.9121)]
    
    func fetchAllPlacesFromServer() -> [Place] {
        var placeArray = [Place]()
        placeArray.append(Place(name: "Zgrade",
                                description: "Ovo su zgrade na nasem kvartu.",
                                sightType: "Building",
                                polygon: MKPolygon(coordinates: zgradeKvart, count: zgradeKvart.count)))
        
        placeArray.append(Place(name: "Vivas",
                                description: "Vivas je poznati kvartovski kacic.",
                                sightType: "Caffe bar",
                                polygon: MKPolygon(coordinates: vivas, count: vivas.count)))
        
        placeArray.append(Place(name: "Zuza",
                                description: "Zuza je poznato kvartovsko okupljaliste.",
                                sightType: "Trg",
                                polygon: MKPolygon(coordinates: zuza, count: zuza.count)))
        
        return placeArray
    }
}
