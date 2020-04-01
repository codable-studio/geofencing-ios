//
//  GeofencingError.swift
//  Geofencing
//
//  Created by Krešimir Baković on 25/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import Foundation

enum GeofencingError: Error {
    case defaultError
    case dataMakingError
    case serverError(Error)
    
    var errorMessage: String {
        switch self {
        case .defaultError:
            return "Default error."
        case .dataMakingError:
            return "Unable to make data."
        case .serverError(let error):
            return "\(error.localizedDescription)"
        }
    }
}
