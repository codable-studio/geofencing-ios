//
//  MapViewModel.swift
//  Geofencing
//
//  Created by Krešimir Baković on 24/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import Foundation
import RxSwift

class MapViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let placeNetworking: PlaceNetworkingProtocol
    
    var mapViewControllerStarted = PublishSubject<Void>()
    
    var placeFetchingResponse: Observable<[Place]>!
    
    
    init(placeNetworking: PlaceNetworkingProtocol) {
        self.placeNetworking = placeNetworking
        setUpObservables()
    }
    
    private func setUpObservables() {
        placeFetchingResponse = mapViewControllerStarted
            .flatMapLatest({ [weak self] _ -> Observable<[Place]> in
                guard let `self` = self else { return Observable.empty() }
                return Observable.just(self.placeNetworking.fetchAllPlacesFromServer())
            })
    }
    
}
