//
//  Cordinator.swift
//  Geofencing
//
//  Created by Krešimir Baković on 16/12/2019.
//  Copyright © 2019 Krešimir Baković. All rights reserved.
//
import Foundation
import UIKit

class Coordinator {
    
    var window: UIWindow!
    
    static let shared = Coordinator()
    
    private init() {}
    
    func start(_ window: UIWindow) {
        self.window = window
        startMapViewController()
    }
    
    func startMapViewController() {
        let placeNetworking = PlaceNetworkingMock()
        let mapViewModel = MapViewModel(placeNetworking: placeNetworking)
        let mapViewController = MapViewController(mapViewModel: mapViewModel)
        let navigationController = UINavigationController(rootViewController: mapViewController)
        window.rootViewController = navigationController
    }
}
