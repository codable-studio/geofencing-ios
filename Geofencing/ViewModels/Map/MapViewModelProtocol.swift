//
//  MapViewModelProtocol.swift
//  Geofencing
//
//  Created by Krešimir Baković on 26/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import Foundation
import RxSwift

protocol MapViewModelProtocol {
    var placeFetchingResponse: ReplaySubject<[Place]> { get }
}
