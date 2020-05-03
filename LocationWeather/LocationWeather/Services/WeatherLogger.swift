//
//  WeatherLogger.swift
//  LocationWeather
//
//  Created by Vivatum on 30/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation
import MapKit
import RealmSwift
import CocoaLumberjack

protocol WeatherLoggerProtocol: class {
    func logCurrentWeatherInfo(_ notification: Notification)
    func getWeatherInfo(_ location: CLLocation)
    func addWeatherRecord(_ weather: WeatherResponse, _ location: CLLocation)
}

final class WeatherLogger: WeatherLoggerProtocol {
    
    static let shared = WeatherLogger()
    private var lastRequestDate: Date?
    private let minRequestIntervalMinute = 10
    
    private init(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.logCurrentWeatherInfo), name:NSNotification.Name(rawValue: AppNotificationKey.UserLocationUpdated.rawValue), object: nil)
    }
    
    private func readyToSendNewRequest() -> Bool {
        guard let lastDate = self.lastRequestDate else { return true }
        let calendar = Calendar.current
        let controlDate = calendar.date(byAdding: .minute, value: self.minRequestIntervalMinute, to: lastDate)
        return Date() > controlDate ?? lastDate
    }
    
    @objc func logCurrentWeatherInfo(_ notification: Notification) {
        guard let currentLocation = notification.userInfo?[NotificationUserInfoKey.location] as? CLLocation else {
            DDLogError("Can't get current user location from Notification")
            return
        }
        
        guard self.readyToSendNewRequest() else {
            DDLogInfo("Too frequent requests. Waiting... ")
            return
        }
        
        self.getWeatherInfo(currentLocation)
    }
    
    func getWeatherInfo(_ location: CLLocation) {
        WeatherFetchService.shared.fetchWeatherInfo(for: location) { result in
            switch result {
            case .success(let response):
                DDLogInfo("Load Weather info Success")
                self.addWeatherRecord(response, location)
            case .failure(let error):
                DDLogError("Can't load Weather info: \(error.localizedDescription)")
            }
        }
    }
    
    func addWeatherRecord(_ weather: WeatherResponse, _ location: CLLocation) {
        let record = WeatherRecord(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, weather: weather)
        self.lastRequestDate = record.date
        
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(record)
                        DDLogInfo("New Weather record added")
                    }
                }
                catch let error {
                    DDLogError("Can't add New Weather record: \(error.localizedDescription)")
                }
            }
        }
    }
    
}
