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
    
    private let mapViewModel: MapViewModelProtocol
    private let disposeBag = DisposeBag()
    
    private let mapView = MKMapView()
    private let segmentedControl = UISegmentedControl()
    
    private var allPlaces = [Place]()
    
    private let mapViewControllerStarted = PublishSubject<Void>()
    
    init(mapViewModel: MapViewModelProtocol) {
        self.mapViewModel = mapViewModel
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
        
        mapViewModel.placeFetchingResponse
            .subscribe(onNext: { [weak self] places in
                guard let `self` = self else { return }
                self.allPlaces = places
                PlaceManager.shared.allPlaces = places
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
        for place in allPlaces {
            mapView.addOverlay(place.polygon)
        }
        let cordinate = CLLocationCoordinate2D(latitude: 45.79694999999999, longitude: 15.913549999999999)
        let a = MKCircle(center: cordinate, radius: CLLocationDistance(exactly: 48.48319118416196)!)
        mapView.addOverlay(a)
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
        } else if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = .red
            circle.lineWidth = 1
            return circle
        }
        return MKPolylineRenderer(overlay: overlay)
    }
}
