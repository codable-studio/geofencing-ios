////
////  PlaceFactory.swift
////  Geofencing
////
////  Created by Krešimir Baković on 25/03/2020.
////  Copyright © 2020 Codable Studio. All rights reserved.
////
//
//import Foundation
//import MapKit
//
//class PlaceFactory {
//    static func convertPlaceServerData(from placeServerData: [String: Any]) throws -> Place {
//        guard let name = placeServerData["name"] as? String else { throw GeofencingError.dataMakingError }
//        guard let description = placeServerData["description"] as? String else { throw GeofencingError.dataMakingError }
//        guard let sightType = placeServerData["sightType"] as? String else { throw GeofencingError.dataMakingError }
//        guard let locationCoordinates = placeServerData["locationCoordinates"] as? [[String: Any]] else {
//            throw GeofencingError.dataMakingError
//        }
//        let polygon = convertLocationCoordinatesToPolygon(locationCoordinates: locationCoordinates)
//        
//        let place = Place(name: name, description: description, sightType: sightType, polygon: polygon)
//        return place
//    }
//    
//    static func convertLocationCoordinatesToPolygon(locationCoordinates: [[String: Any]]) -> MKPolygon {
//        var clLocationCoordinatesArray = [CLLocationCoordinate2D]()
//        for locationCoordinate in locationCoordinates {
//            do {
//                let clLocationCoordinate = try convertLocationCoordinateToCLLocationCoordinate(locationCoordinate: locationCoordinate)
//                clLocationCoordinatesArray.append(clLocationCoordinate)
//            } catch (let error) {
//                print("ERROR occured: \(error.localizedDescription)")
//            }
//        }
//        let polygon = MKPolygon(coordinates: clLocationCoordinatesArray, count: clLocationCoordinatesArray.count)
//        return polygon
//    }
//    
//    static func convertLocationCoordinateToCLLocationCoordinate(locationCoordinate: [String: Any]) throws -> CLLocationCoordinate2D {
//        guard let longitude = locationCoordinate["longitude"] as? String else { throw GeofencingError.dataMakingError }
//        guard let latitude = locationCoordinate["latitude"] as? String else { throw GeofencingError.dataMakingError }
//        guard let doubleLongitude = Double(longitude) else { throw GeofencingError.dataMakingError }
//        guard let doubleLatitude = Double(latitude) else { throw GeofencingError.dataMakingError }
//        let clLocationCoordinate = CLLocationCoordinate2D(latitude: doubleLatitude, longitude: doubleLongitude)
//        return clLocationCoordinate
//    }
//}
