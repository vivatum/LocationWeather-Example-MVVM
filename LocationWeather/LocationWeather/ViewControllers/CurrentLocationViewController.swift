//
//  CurrentLocationViewController.swift
//  LocationWeather
//
//  Created by Vivatum on 29/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import UIKit
import MapKit
import CocoaLumberjack


final class CurrentLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private let navTitle = "Current location"
    private let mapSpanDistance: CLLocationDegrees = 0.03
    private var mapRegionDidSet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.navTitle
        self.mapView.showsUserLocation = true
    }
    
    private func setupMapRegion() {
        guard !self.mapRegionDidSet else { return }
        DispatchQueue.main.async {
            var region = self.mapView.region
            region.center = self.mapView.userLocation.coordinate
            region.span = MKCoordinateSpan(latitudeDelta: self.mapSpanDistance, longitudeDelta: self.mapSpanDistance)
            self.mapView.setRegion(region, animated: true)
            self.mapRegionDidSet = true
        }
    }
}

extension CurrentLocationViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        DDLogError("Did Fail To Locate User with error: \(error)")
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        DDLogError("Map View Did Fail Loading with error: \(error)")
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if let userLocationView = mapView.view(for: mapView.userLocation) {
            userLocationView.isSelected = true
            let userCoordinate = mapView.userLocation.coordinate
            mapView.userLocation.title = userCoordinate.shortToString()
        }
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        self.setupMapRegion()
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let userLocationView = mapView.view(for: mapView.userLocation) {
            userLocationView.isSelected = true
            let userCoordinate = mapView.userLocation.coordinate
            mapView.userLocation.title = userCoordinate.shortToString()
        }
    }
    
}
