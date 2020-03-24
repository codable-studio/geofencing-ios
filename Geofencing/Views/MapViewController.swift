//
//  MapViewController.swift
//  Geofencing
//
//  Created by Krešimir Baković on 24/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    private let mapViewModel: MapViewModel
    
    init(mapViewModel: MapViewModel) {
        self.mapViewModel = mapViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
