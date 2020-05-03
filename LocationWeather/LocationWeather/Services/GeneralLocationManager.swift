//
//  GeneralLocationManager.swift
//  LocationWeather
//
//  Created by Vivatum on 29/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation
import MapKit
import CocoaLumberjack

final class GeneralLocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = GeneralLocationManager()
    
    lazy var locationManager: CLLocationManager? = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()
    
    private override init() {
        super.init()
        DDLogInfo("GeneralLocationManager did init")
    }
    
    public func locationAccessRequest() {
        DDLogInfo("start Location access request...")
        if CLLocationManager.locationServicesEnabled() {
            let status = CLLocationManager.authorizationStatus()
            self.handleAuthorizationStatus(status)
        } else {
            self.locationManager?.stopUpdatingLocation()
            let message = "Please enable location service."
            AlertHelper.showPermissionLocationAlert(with: message)
            DDLogError("Location Services is not Enabled")
        }
    }
    
    private func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager?.startUpdatingLocation()
            DDLogInfo("Location Service: start updating user location")
            break
        case .notDetermined:
            self.locationManager?.requestWhenInUseAuthorization()
            DDLogInfo("Location Service: request authorization")
            break
        default:
            self.locationManager?.stopUpdatingLocation()
            DDLogInfo("Location Service status .denied or .restricted: need to open Settings")
            let message = "Please go into Settings and give this app authorization to your location."
            AlertHelper.showPermissionLocationAlert(with: message)
            break
        }
    }
    
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            AppNotification.send(notification: AppNotificationKey.UserLocationUpdated, userInfo: [NotificationUserInfoKey.location : lastLocation])
            DDLogInfo("User Location was updated")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DDLogError("Location Error: \(error.localizedDescription)")
        AlertHelper.showErrorAlert(ActionError.location(error.localizedDescription).alertContent)
    }
    
}
