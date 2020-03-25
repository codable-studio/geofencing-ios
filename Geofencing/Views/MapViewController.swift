//
//  MapViewController.swift
//  Geofencing
//
//  Created by Krešimir Baković on 24/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class MapViewController: UIViewController {
    
    private let mapViewModel: MapViewModel
    private let disposeBag = DisposeBag()
    
    private let placeNetworking: PlaceNetworkingMock
    
    private let mapView = MKMapView()
    
    private let segmentedControl = UISegmentedControl()
    
    init(mapViewModel: MapViewModel,
         placeNetworking: PlaceNetworkingMock) {
        self.mapViewModel = mapViewModel
        self.placeNetworking = placeNetworking
        PlaceManager.shared.allPlaces = placeNetworking.fetchAllPlacesFromServer()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        setUpObservables()
        setUpMapView()
        createCustomPolygonShapesOnMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar()
    }
    
    private func render() {
        renderMapView()
        renderSegmentedControl()
    }
    
    private func setUpObservables() {
        segmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] selectedIndex in
                guard let `self` = self else { return }
                if selectedIndex == 0 {
                    self.mapView.mapType = .standard
                } else if selectedIndex == 1 {
                    self.mapView.mapType = .mutedStandard
                } else if selectedIndex == 2 {
                    self.mapView.mapType = .satellite
                }
            }).disposed(by: disposeBag)
    }
    
    private func setUpMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    private func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func createCustomPolygonShapesOnMap() {
        let places = placeNetworking.fetchAllPlacesFromServer()
        for place in places {
            mapView.addOverlay(place.polygon)
        }
    }
}

// MARK: - UI rendering
private extension MapViewController {
    func renderMapView() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func renderSegmentedControl() {
        view.addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
        segmentedControl.insertSegment(withTitle: "Map", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Transit", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "Satellite", at: 2, animated: true)
        segmentedControl.selectedSegmentIndex = 0
    }
}

// MARK: - MKMapView delegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = .red
            polygonView.fillColor = .yellow
            polygonView.lineWidth = 3
            return polygonView
        }
        return MKPolylineRenderer(overlay: overlay)
    }
}
