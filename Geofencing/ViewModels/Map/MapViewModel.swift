//
//  MapViewModel.swift
//  Geofencing
//
//  Created by Krešimir Baković on 24/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import Foundation
import RxSwift

class MapViewModel: MapViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    
    private let placeNetworking: PlaceNetworkingProtocol
    
    var placeFetchingResponse = ReplaySubject<[Place]>.create(bufferSize: 1)
    
    init(placeNetworking: PlaceNetworkingProtocol) {
        self.placeNetworking = placeNetworking
        setUpObservables()
    }
    
    private func setUpObservables() {
        self.placeNetworking.fetchAllPlacesFromServer()
            .subscribe(onNext: { [weak self] places in
                guard let `self` = self else { return }
                self.placeFetchingResponse.onNext(places)
            }).disposed(by: self.disposeBag)
    }
}
