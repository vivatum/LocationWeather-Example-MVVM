//
//  WeatherRecord.swift
//  LocationWeather
//
//  Created by Vivatum on 29/04/2020.
//  Copyright © 2020 com.vivatum. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

final class WeatherRecord: Object {
    @objc dynamic var date = Date()
    @objc dynamic var latitude: Float = 0
    @objc dynamic var longitude: Float = 0
    @objc dynamic var temperature: Double = 0
    @objc dynamic var temperatureMax: Double = 0
    @objc dynamic var weatherDescription: String = ""
    
    convenience init(latitude: Double, longitude: Double, weather: WeatherResponse) {
        self.init()
        self.latitude = Float(latitude)
        self.longitude = Float(longitude)
        self.temperature = weather.temperature
        self.temperatureMax = weather.temperatureMax
        self.weatherDescription = weather.description
    }
}

extension WeatherRecord {
    
    func coordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(self.latitude), longitude: Double(self.longitude))
    }
}

